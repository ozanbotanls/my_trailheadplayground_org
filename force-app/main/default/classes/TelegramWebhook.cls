// Telegram's "setWebhook" API pings this custom exposed REST API, whenever an update happens on Telegram channel.
@RestResource(urlMapping='/telegram/*')
global with sharing class TelegramWebhook {
    public static final String TELEGRAM_ORIGIN = '[Telegram] ';
    @HttpPost
    global static void getWebHookUpdate() {
        RestRequest req = RestContext.request;
        if (req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1) != TelegramUtility.TELEGRAM_CHAT_TOKEN) {
            System.debug('Telegram chatbot token is not provided. Can not proceed');
            return;
        }
        Telegram.WebhookUpdate webhookUpdate = TelegramUtility.buildWebhookUpdate(req.requestBody.toString());
        TelegramWebhookController.onUpdateReceived(webhookUpdate);
    }
}