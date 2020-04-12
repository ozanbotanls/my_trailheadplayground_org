public with sharing class Telegram {
    /* ========================================
     * Wrapper classes STARTING
     * to be used for GENERATING Telegram payload
     * They will be used in HTTP request from SFDC to Telegram
     * =======================================*/
    // https://core.telegram.org/bots/api/#inlinekeyboardbutton
    public class InlineKeyboard {
        public String text;
        public String callback_data;
        public String url;
    }
    // https://core.telegram.org/bots/api/#keyboardbutton
    public class ReplyKeyboard {
        public String text;
    }
    /* ========================================
     * Wrapper classes STARTING
     * to be used for PARSING Telegram payload
     * They will be used in APIs from Telegram to SFDC
     * =======================================*/
    // https://core.telegram.org/bots/api/#update
    public class WebhookUpdate {
        public TelegramMessage message;
        public CallbackQuery callBackQuery;
        public InlineQuery inlineQuery;
        // returns TelegramUser object holding user info.
        public TelegramUser getSender() {
            if (isCallback()) {
                return this.callBackQuery.fromUser;
            }
            if (isInline()) {
                return this.inlineQuery.fromUser;
            }
            return message.fromUser;
        }
        // returns incoming text message from TelegramUser
        // options: Text, Callback Text or InlineQuery Text
        public String getMessage() {
            if (isCallback()) {
                return this.callBackQuery.data;
            }
            if (isInline()) {
                return this.inlineQuery.query;
            }
            if (isText()) {
                return message.text;
            }
            // for video, photo, sticker, voice etc.
            return '';
        }
        public Boolean isCallback() {
            return this.callBackQuery != null;
        }
        public Boolean isInline() {
            return this.inlineQuery != null;
        }
        public Boolean isText() {
            return this.message.text != null;
        }
        public Boolean isPhoto() {
            return this.message.photo != null;
        }
        public Boolean isSticker() {
            return this.message.sticker != null;
        }
        public Boolean isVoice() {
            return this.message.voice != null;
        }
    }
    // https://core.telegram.org/bots/api/#message
    public class TelegramMessage {
        public String message_id;
        public String text;
        public Object photo;
        public Object sticker;
        public Object voice;
        public TelegramUser fromUser;
    }
    // https://core.telegram.org/bots/api/#callbackquery
    public class CallbackQuery {
        public String id;
        public String data;
        public TelegramUser fromUser;
    }
    // https://core.telegram.org/bots/api/#inlinequery
    public class InlineQuery {
        public String id;
        public String query;
        public TelegramUser fromUser;
    }
    // https://core.telegram.org/bots/api/#user
    public class TelegramUser {
        public String id;
        public String first_name;
        public String last_name;
        public String username;
        public Boolean is_bot;
    }
}