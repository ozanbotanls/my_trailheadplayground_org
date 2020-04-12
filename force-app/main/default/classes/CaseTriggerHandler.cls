public with sharing class CaseTriggerHandler {
    public static void createCaseFromTelegram(List<Case> caseList) {
        for (Case insertedCase : caseList) {
            // only take into account Telegram-rooted Cases records created automatically.
            if (insertedCase.Subject.contains(TelegramWebhook.TELEGRAM_ORIGIN)) {
                String replyMessage = 'You have opened a new case in Salesforce with the following details;\r\n';
                replyMessage += '*Case Id: *' + insertedCase.Id + '\r\n';
                replyMessage += '*Case Subject: *' + insertedCase.Subject + '\r\n';
                replyMessage += '*Case Status: *' + insertedCase.Status + '\r\n';
                replyMessage += '*Created Date: *' + insertedCase.CreatedDate + '\r\n';
                String chatId = insertedCase.Subject.split(':')[1];
                // send out a reply message to the user informing a case has been created.
                new TelegramMessage.Text(replyMessage).get().sendMessage(chatId, false);
            }
        }
    }
}