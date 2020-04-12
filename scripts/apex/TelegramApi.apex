// register webhook to get updates
String publicSiteRest = 'https://ozanbotan-developer-edition.na85.force.com/telegram/services/apexrest/telegram/'

// Telegram instance testing
Telegram telegramInstance = new Telegram('123456');
Telegram.InlineKeyboard inlineKeyboard = new Telegram.InlineKeyboard();
inlineKeyboard.text = 'Get User Info';
inlineKeyboard.callback_data = 'getUserInfo';
String requestPayload = telegramInstance.text('test message')
                            .addInlineKeyboard(new List<Telegram.InlineKeyboard> { inlineKeyboard })
                            .get();
System.debug(requestPayload);

/*
{
    "text":"test message",
    "reply_markup":[[{"text":"Get User Info","callback_data":"getUserInfo"}]],
    "chat_id":"123456"
}
*/

String asd = '{"id" : "12345", "message" : { "id" : "123", "text" : "sample text"}}';
Map<String, Object> telegramPayload = (Map<String, Object>)JSON.deserializeUntyped(asd);
String deepId = (String)((Map<String, Object>)telegramPayload.get('message')).get('id');
System.debug(deepId);
////////////////////////
////////////////////////
Telegram.InlineKeyboard inlineKeyboard1 = new Telegram.InlineKeyboard();
inlineKeyboard1.text = 'Open a Case';
inlineKeyboard1.callback_data = 'openCase';
Telegram.InlineKeyboard inlineKeyboard2 = new Telegram.InlineKeyboard();
inlineKeyboard2.text = 'Get User Info';
inlineKeyboard2.callback_data = 'getUserInfo';
// Telegram.ReplyKeyboard replyKeyboard1 = new Telegram.ReplyKeyboard();
// replyKeyboard1.text = 'Open a Case';
// Telegram.ReplyKeyboard replyKeyboard2 = new Telegram.ReplyKeyboard();
// replyKeyboard2.text = 'Get User Info';
TelegramMessage.TelegramMessageWrapper wrapper = new TelegramMessage.Text('test')
    //.setChatId('chatId')
    .addInlineKeyboard(new List<Telegram.InlineKeyboard>{ inlineKeyboard1, inlineKeyboard2 })
    //.addReplyKeyboard(new List<Telegram.ReplyKeyboard>{ replyKeyboard1, replyKeyboard2 }, true, true)
    .get();
System.debug(wrapper.templateBody);
String response = wrapper.sendMessage();
System.debug(response);