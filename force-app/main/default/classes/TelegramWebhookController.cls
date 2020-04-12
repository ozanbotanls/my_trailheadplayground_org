public with sharing class TelegramWebhookController {
    public static void onUpdateReceived(Telegram.WebhookUpdate webhookUpdate) {
        Telegram.TelegramUser telegramUser = webhookUpdate.getSender();
        String chatId = telegramUser.id;
        String incomingText = webhookUpdate.getMessage();

        // meaning, incoming reponse is stemmed from CallbackQuery.
        if (webhookUpdate.isCallback()) {
            if (incomingText == 'openCase') {
                String response = new TelegramMessage.Text('Please type Case subject')
                    .forceReply()
                    .get()
                    .sendMessage(chatId, true);
                //Case newCase = new Case(Subject = TELEGRAM_ORIGIN + ':' + chatId, Origin = 'Phone', Status = 'New');
                //insert newCase;
            } else if (incomingText == 'getContact') {
                new TelegramMessage.Contact('+1 444 12 11', 'Telegram', 'User').get().sendMessage(chatId, true);
            }
            return;
        }

        // meaning, incoming reponse is stemmed from InlineQuery.
        if (webhookUpdate.isInline()) {
            // @TODO: implement inline query handler logic.
            new TelegramMessage.Text('Inline Query Response: You chose this option: ' + incomingText)
                .get()
                .sendMessage(chatId, true);
            return;
        }

        // this snippet steps in when user types any text OR presses replyKeyboard button (as text) in chat conversation.
        if (webhookUpdate.isText()) {
            if (incomingText == '/start') {
                // new TelegramMessage.Sticker('https://www.gstatic.com/webp/gallery/1.webp')
                //     .get()
                //     .sendMessage(chatId, true);
                // new TelegramMessage.Location(51.521727, -0.117255).get().sendMessage(chatId, true);

                Telegram.InlineKeyboard inlineKeyboard1 = new Telegram.InlineKeyboard();
                inlineKeyboard1.text = 'Open a Case';
                inlineKeyboard1.callback_data = 'openCase';
                Telegram.InlineKeyboard inlineKeyboard2 = new Telegram.InlineKeyboard();
                inlineKeyboard2.text = 'Get My Contact Info';
                inlineKeyboard2.callback_data = 'getContact';
                // Telegram.ReplyKeyboard replyKeyboard1 = new Telegram.ReplyKeyboard();
                // replyKeyboard1.text = 'Open a Case';
                // Telegram.ReplyKeyboard replyKeyboard2 = new Telegram.ReplyKeyboard();
                // replyKeyboard2.text = 'Get User Info';
                new TelegramMessage.Text('Thanks for launching SFDC actions. Please choose one')
                    //.addReplyKeyboard(new List<Telegram.ReplyKeyboard>{ replyKeyboard1, replyKeyboard2 }, true, true)
                    .addInlineKeyboard(new List<Telegram.InlineKeyboard>{ inlineKeyboard1, inlineKeyboard2 })
                    .get()
                    .sendMessage(chatId, true);
            } else if (incomingText == 'Open a Case' || incomingText == 'Get User Info') {
                new TelegramMessage.ChatAction('typing').get().sendMessage(chatId, true);
                new TelegramMessage.Text('Your choice was *' + incomingText + '*').get().sendMessage(chatId, true);
            } else {
                // new TelegramMessage.Photo('https://telegram.org/img/t_logo.png', 'Telegram Logo')
                //     .get()
                //     .sendMessage(chatId, true);
                new TelegramMessage.ChatAction('typing').get().sendMessage(chatId, true);
                new TelegramMessage.Text(
                        'Hey *' +
                        telegramUser.first_name +
                        '!* What\'s up? Please use /start command to launch Salesforce actions.'
                    )
                    .get()
                    .sendMessage(chatId, true);
            }
        }
    }
}