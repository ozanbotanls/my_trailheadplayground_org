public with sharing class TelegramUtility {
    public static final String TELEGRAM_CHAT_TOKEN = '702425041:AAHKHixL6yHi_4fSdvFgi5LH1HL8GREt5b8'; // for salesforce-telegram-bot channel
    public static String sendMessage(String data, String method, Boolean isImmediate) {
        if (isImmediate) {
            return sendImmediate(data, method);
        } else {
            sendFuture(data, method);
            return null;
        }
    }

    private static String sendImmediate(String data, String method) {
        return sendMessageHandler(data, method);
    }

    @future(callout=true)
    private static void sendFuture(String data, String method) {
        sendMessageHandler(data, method);
    }

    private static String sendMessageHandler(String data, String method) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.telegram.org/bot' + TELEGRAM_CHAT_TOKEN + '/' + method);
        req.setMethod('POST');
        req.setHeader('content-type', 'application/json');
        req.setBody(data);
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug(res.getBody());
        return res.getBody();
    }

    public static Telegram.WebhookUpdate buildWebhookUpdate(String payload) {
        Map<String, Object> telegramPayload = (Map<String, Object>) JSON.deserializeUntyped(payload);
        Boolean isCallback = telegramPayload.containsKey('callback_query');
        Boolean isInline = telegramPayload.containsKey('inline_query');
        Telegram.WebhookUpdate webhook = new Telegram.WebhookUpdate();
        // callbackquery update
        if (isCallback) {
            Map<String, Object> callbackQuery = (Map<String, Object>) telegramPayload.get('callback_query');
            webhook.callBackQuery = buildCallbackQuery(callbackQuery);
        }
        // inlinequery update
        if (isInline) {
            Map<String, Object> inlineQuery = (Map<String, Object>) telegramPayload.get('inline_query');
            webhook.inlineQuery = buildInlineQuery(inlineQuery);
        }
        // non of them. just a regular message type of text, photo, etc.
        if (!isCallback && !isInline) {
            Map<String, Object> messageMap = (Map<String, Object>) telegramPayload.get('message');
            webhook.message = buildMessage(messageMap);
        }
        return webhook;
    }

    private static Telegram.TelegramMessage buildMessage(Map<String, Object> message) {
        Telegram.TelegramMessage telegramMessage = new Telegram.TelegramMessage();
        telegramMessage.message_id = String.valueOf((Integer) message.get('message_id'));
        telegramMessage.fromUser = buildUser((Map<String, Object>) message.get('from'));
        telegramMessage.text = message.containsKey('text') ? (String) message.get('text') : null;
        telegramMessage.photo = message.containsKey('photo') ? message.get('photo') : null;
        telegramMessage.sticker = message.containsKey('sticker') ? message.get('sticker') : null;
        telegramMessage.voice = message.containsKey('voice') ? message.get('voice') : null;
        return telegramMessage;
    }

    private static Telegram.CallbackQuery buildCallbackQuery(Map<String, Object> callbackQuery) {
        Telegram.CallbackQuery callback = new Telegram.CallbackQuery();
        callback.data = (String) callbackQuery.get('data');
        callback.id = (String) callbackQuery.get('id');
        callback.fromUser = buildUser((Map<String, Object>) callbackQuery.get('from'));
        return callback;
    }

    private static Telegram.InlineQuery buildInlineQuery(Map<String, Object> inlineQuery) {
        Telegram.InlineQuery inline = new Telegram.InlineQuery();
        inline.query = (String) inlineQuery.get('query');
        inline.id = (String) inlineQuery.get('id');
        inline.fromUser = buildUser((Map<String, Object>) inlineQuery.get('from'));
        return inline;
    }

    private static Telegram.TelegramUser buildUser(Map<String, Object> sender) {
        Telegram.TelegramUser telegramUser = new Telegram.TelegramUser();
        telegramUser.id = String.valueOf((Integer) sender.get('id'));
        telegramUser.first_name = (String) sender.get('first_name');
        telegramUser.last_name = (String) sender.get('last_name');
        telegramUser.username = (String) sender.get('username');
        telegramUser.is_bot = (Boolean) sender.get('is_bot');
        return telegramUser;
    }
}