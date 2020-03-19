import 'select2';
import "bootstrap";
import "slick";
import { initSelect2 } from '../plugins/init_select2';
import { initDevFilter, hideDevs } from '../plugins/developer_filter';
import { scrollMessagesWrapper, bindConversations } from '../plugins/scroll_messages_wrapper.js';

initSelect2();
initDevFilter();
scrollMessagesWrapper();
bindConversations();
