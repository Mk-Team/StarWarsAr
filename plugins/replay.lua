-- __  __                    _       
--|  \/  | __ _ _ __ ___ ___| | ___  
--| |\/| |/ _` | '__/ __/ _ \ |/ _ \ 
--| |  | | (_| | | | (_|  __/ | (_) |
--|_|  |_|\__,_|_|  \___\___|_|\___/ 
-- BY :- @iiDii Ch :- @Star_Wars
do 
local function run(msg, matches) 

if is_silent_user(msg.from.id, msg.to.id) then return end

local w = matches[1]
local ww = matches[2]
local r3 = matches[3]
local r4 = matches[4]
local name_user = string.sub(msg.from.first_name:lower(),0,60) 
local data = load_data(_config.moderation.data)
if msg.from.username then
usernamex = "@"..(msg.from.username or "---")
else
usernamex = "️ لا يوجد ! "
end

--------------[data function to save rdod ]---------------
if data[tostring(msg.to.id)] then
if data[tostring(msg.to.id)]['settings'] then
local settings = data[tostring(msg.to.id)]['settings'] 
if data[tostring(msg.to.id)]['settings']['replay'] then
 lock_reply = data[tostring(msg.to.id)]['settings']['replay']  
 elseif not data[tostring(msg.to.id)]['settings']['replay'] then
 lock_reply = "☑️"
end end end

---------------[End Function data] -----------------------
 if w=="رد" then
 if not is_owner(msg) then
     return"للمدراء فقط 🚻 عزيزي !"
     end
     
  if ww == 'مسح الكل' then
if next(data[tostring(msg.to.id)]['replay']) == nil then
return  " عذراً عزيزي !".. ":{" ..msg.from.first_name.. "}:".."\n".."\n".." قائمة الردود فارغة بالفعل 📭 "
else
for k,v in pairs(data[tostring(msg.to.id)]['replay']) do
data[tostring(msg.to.id)]['replay'][tostring(k)] = nil
save_data(_config.moderation.data, data)
end
    return "تم حذف 🚮 جميع الردود بنجاح ✅"
end
end

  if ww == 'اضف' then
 data[tostring(msg.to.id)]['replay'][r3] = r4
save_data(_config.moderation.data, data)
 return '('..r3..')\n  تم اضافة ➕ الرد بنجاح ✅'
 
elseif ww == 'مسح' then
if not data[tostring(msg.to.id)]['replay'][r3] then
return 'عذرا هذا الرد 📝 ليش مضاف في قائمة الردود !'
else
data[tostring(msg.to.id)]['replay'][r3] = nil
save_data(_config.moderation.data, data)
return '('..r3..')\n  تم حذف 🚮 الرد بنجاح ✅ '
end
end
end

  if w == 'الردود' then
if next(data[tostring(msg.to.id)]['replay']) ==nil then
return 'لا توجد 📭 ودود مضافه حالياً ⚡️'
else
local i = 1
local message = 'ردود البوت ⚡️ في المجموعة 🚻 !\n\n'
for k,v in pairs(data[tostring(msg.to.id)]['replay']) do
message = message ..i..' - '..k..' [' ..v.. '] \n'
i = i + 1
end
return message
end

  end
 



--------------------[Roun Bot]----------------------------
if w =="رن" then
return "تم اعادة 🔄 تشغيل البوت  ⚡️"
elseif w == "اسمي" then
return  "\n" ..msg.from.first_name.."\n" 
elseif w == "معرفي" then
return  "@"..(msg.from.username or " لايوجد لديك معرف ؟").."\n" 
elseif w == "رقمي" then
return  "\n"..(msg.from.phone or "لايوجد لديك رقم !").."\n" 
elseif w == "ايديي" then
return  "\n"..msg.from.id.."\n" 
elseif w =="صورتي" then
local function getpro(arg, data)
if data.photos_[0] then
local rank
if is_sudo(msg) then
rank = 'انت مطور 👨🏻‍🔧 في هذا البوت 😃'
elseif is_owner(msg) then
rank = 'انت مدير 🚻 هذا المجموعة !'
elseif is_admin(msg) then
rank = ' انت اداري 🔧 في المجموعة'
elseif is_mod(msg) then
rank = ' انت ادمن 👷🏼 في المجموعة'
else
rank = 'انت عضو 🚹 في المجموعة !'
end
tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,"",dl_cb,nil)
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "*>* لا يوجد صوره في بروفايلك ...", 1, 'md')
end end
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.from.id,offset_ = 0,limit_ = 1}, getpro, nil)
elseif w=="اريد رابط الحذف" or w=="اريد رابط حذف" or w=="رابط حذف" or w=="رابط الحذف" then
return [[ لحذف حسابك ⛔️ اضغط على الرابط ادناه ⤵️ ثم سجل رقمك لحذف حسابك ! 
https://telegram.org/deactivate
]] 
elseif w== 'ايدي' and msg.to.type == 'pv' then
return "> ايدي البوت : "..msg.to.id.. "\n\n>  ايدي حسابك : "..msg.from.id..""

end
--BY - @Star_Wars
    
if (msg.to.type == "pv") and not is_sudo(msg) then
tdcli.sendMessage(msg.to.id, 0, 1, " مرحبا بكم في بوت *Star Ware* يستطيع هذا البوت حماية مجموعتك 🚻 من - الروابط - اعادة التوجية - الملصقات - وغيرها... \n\n*1-* يعمل البوت على مدار *24* ساعة \n*2-* يعمل البوت بلغة العربيه والانكليزية ⚡️\n*3-* سريع للاستجابة للاوامر 🆙\n*4-* لتفعيل البوت في مجموعتك  *1$* للاشتراك الشهري \n\n*>* قناتنا :- @Star_Wars\n*>* للتواصل :- @iiDii", 1, 'md')
local pvmsg ="*>* _الاسم_ :*"..name_user.."*\n*>* _الايدي :-_ ["..msg.from.id.."]\n*> _المعرف :-_ ["..usernamex.."]\n*>* _📥الرسالة:-_ \n\n"..msg.text

tdcli.sendMessage(60809019, 0, 1, pvmsg, 1, 'md')

end
    
--------------------------------------

if lock_reply =="☑️️" and  data[tostring(msg.to.id)]    then

if ( msg.text ) and ( msg.to.type == "channel" ) or ( msg.to.type == "chat" ) then
    ----------------------
    -- by @iiDii
local su = {
"نعم حبيبي المطور 🌝❤",
"يابعد روح ستار وارز 😘❤️",
"هلا بمطوري العشق أمرني"
  }
local  ss97 = {
"ها حياتي😻",
"عيونه 👀 وخشمه 👃🏻واذانه👂🏻",
"باقي ويتمدد 😎",
"ها حبي 😍",
"ها عمري 🌹",
"اجيت اجيت كافي لتصيح 🌚👌",
"هياتني اجيت 🌚❤️",
"نعم حبي 😎",
"هوه غير يسكت عاد ها شتريد 😷",
"احجي بسرعه شتريد 😤",
"ها يا كلبي ❤️",
"هم صاحو عليه راح ابدل اسمي من وراكم 😡",
"لك فداك حسوني حبيبي انت اموووح 💋",
"دا اشرب جاي تعال غير وكت 😌",
"كول حبيبي أمرني 😍",
"احجي فضني شرايد ولا اصير ضريف ودكلي جرايد لو مجلات تره بايخه 😒😏",
"اشتعلو اهل البوت شتريد 😠",
"بووووووووو 👻 ها ها فزيت شفتك شفتك لا تحلف 😂",
"طالع مموجود 😒",
"هااا شنوو اكو حاته بالكروب وصحت عليه  😍💕",
"انت مو قبل يومين غلطت عليه؟  😒",
"راجع المكتب حبيبي عبالك اني سهل تحجي ويا 😒",
"ياعيون ستار وارز أمرني 😍",
"لك دبدل ملابسي اطلع برااااا 😵😡 ناس متستحي",
"سويت هواي شغلات سخيفه بحياتي بس عمري مصحت على واحد وكلتله انجب 😑",
"مشغول ويا ضلعتي  ☺️",
"مازا تريد منه 😌🍃",

}
local bs = {
"مابوس 🌚💔",
"اآآآم͠ــ.❤️😍ــو͠و͠و͠آ͠آ͠ح͠❤️عسسـل❤️",
"الوجه ميساعد 😐✋",
"ممممح😘ححح😍😍💋",
}
local ns = {
"🌹 هــلــℌelℓoووات🌹عمـ°🌺°ــري🙊😋",
"هْـٌﮩٌﮧٌ﴿🙃﴾ﮩٌـ୭ٌ୭ـْلوُّات†😻☝️",
"هلاوو99وووات نورت/ي ❤️🙈",
"هلووات 😊🌹",
}
local sh = {
"اهلا عزيزي المطور 😽❤️",
"هلوات . نورت مطوري 😍",
}
local lovs =  "اموت عليك حياتي  😍❤️"
local  lovm = {
"اكرهك 😒👌🏿",
"دي 😑👊🏾",
"اعشكك/ج مح 😍💋",
"اي احبك/ج 😍❤️",
"ماحبك/ج 😌🖖",
"امـــوت فيك ☹️",
"اذا كتلك/ج احبك/ج شراح تستفاد/ين 😕❤️",
"ولي ماحبك/ج 🙊💔",
}
local thb = {
"اموت عليه-ه 😻😻",
"فديته-ه 😍❤️",
"لا ماحبه-ه 🌚💔",
"كلخراا عزيزي 💔🌚",
"يييع 😾👊🏿",
"مادري افڱﮩﮩﮩر🐸💔"
}
local song = {
"عمي يبو البار 🤓☝🏿️ \nصبلي لبلبي ترى اني سكران 😌 \n وصاير عصبي 😠 \nانه وياج يم شامه 😉 \nوانه ويــــاج يم شامه  شد شد  👏🏿👏🏿 \nعدكم سطح وعدنه سطح 😁 \n نتغازل لحد الصبح 😉 \n انه وياج يم شامه 😍 \n وانه وياج فخريه وانه وياج حمديه 😂🖖🏿\n ",
"اي مو كدامك مغني قديم 😒🎋 هوه ﴿↜ انـِۨـۛـِۨـۛـِۨيـُِـٌِہۧۥۛ ֆᵛ͢ᵎᵖ ⌯﴾❥  ربي كامز و تكلي غنيلي 🙄😒🕷 آإرۈحُـ✯ـہ✟  😴أنــ💤ــااااام😴  اشرف تالي وكت يردوني اغني 😒☹️🚶",
"لا تظربني لا تظرب 💃💃 كسرت الخيزارانه💃🎋 صارلي سنه وست اشهر💃💃 من ظربتك وجعانه🤒😹",
"موجوع كلبي😔والتعب بية☹️من اباوع على روحي😢ينكسر كلبي عليه😭",
"ايامي وياها👫اتمنا انساها😔متندم اني حيل😞يم غيري هيه💃تضحك😂عليه😔مقهور انام الليل😢كاعد امسح بل رسائل✉️وجان اشوف كل رسايلها📩وبجيت هوايه😭شفت احبك😍واني من دونك اموت😱وشفت واحد 🚶صار هسه وياية👬اني رايدها عمر عمر تعرفني كل زين🙈 وماردت لا مصلحة ولاغايه😕والله مافد يوم بايسها💋خاف تطلع🗣البوسه💋وتجيها حجايه😔️",
 "😔صوتي بعد مت سمعه✋يال رايح بلا رجعة🚶بزودك نزلت الدمعة ذاك اليوم☝️يال حبيتلك ثاني✌روح وياه وضل عاني😞يوم اسود علية اني🌚 ذاك اليوم☝️تباها بروحك واضحك😂لان بجيتلي عيني😢😭 وافراح يابعد روحي😌خل الحركة تجويني😔🔥صوتي بعد متسمعة🗣✋",
 
 
}
-------reply By stickers -------

local sound = {
"data/audio/aml_mnk.ogg",
"data/audio/mozeka.ogg"
}
local function sudoname(ww)
if string.match(ww, 'مارسلو')  or  string.match(ww, 'حسن') or  string.match(ww, 'حسون') or  string.match(ww, 'حسوني')  or string.match(ww, 'مارسيلو') then
return true
else
return false
end
end

----------------------------------------------
if is_sudo(msg) and w == "بوت" and not ww then 
return  su[math.random(#su)]  
elseif not is_sudo(msg) and w == "بوت" and not ww then 
return  ss97[math.random(#ss97)]  
elseif w == "كول" and ww then
if string.len(ww) > 60 then return " ما اكدر اكول اكثر من 60 حرف 🙌🏾" end
if sudoname(ww) then return " ما اكدر احجي عليه مستحيل 😃" end
return tdcli.sendMessage(msg.to.id, 0, 1, '_'..ww..'_', 1, 'md')
elseif w == "كله" and ww then
if string.len(ww) > 60 then return " ما اكدر اكله اكثر من 60 حرف 🙌🏾" end
if sudoname(ww) then return " ما اكدر احجي عليه مستحيل 😁" end
if msg.reply_id then
return tdcli.sendMessage(msg.to.id, msg.reply_id, 1, '<code>'..ww..'</code>', 1, 'html')
end
elseif w == "اتفل" and ww then
if sudoname(ww) then return " ما اكدر اتفل عليه مستحيل 🕵🏻" end
if msg.reply_id then
 tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك سيدي 🌝🍃', 1, 'html')
 tdcli.sendMessage(msg.to.id, msg.reply_id, 1, 'ختفوووووووووو💦💦️️', 1, 'html')
 else 
return"  🕵🏻 وينه بله سويله رد 🙄"
end
elseif w == "بوت رزله" and ww and is_sudo(msg) then
if msg.reply_id then
 tdcli.sendMessage(msg.to.id, msg.id, 1, 'اوك سيدي 🌝🍃', 1, 'html')
 tdcli.sendMessage(msg.to.id, msg.reply_id, 1, 'يا ول شو طالعة عينك😒 من البنات مو😪و هم صايرلك لسان تحجي😠اشو تعال👋👊صير حباب مرة ثانية ترةة ...😉و لا تخليني البسك عمامة و اتفل عليك😂️', 1, 'html')
end
elseif w == "بوس" and ww then 
if sudoname(ww) then
return " "
else
if msg.reply_id then
return  bs[math.random(#bs)] 
else
return " وينه بله سويله رد 😁"
end
end
elseif w == "تحب" and ww then
if sudoname(ww) then
return " "
else
return  thb[math.random(#thb)] 
end
elseif is_sudo(msg) and w =="هلو" then
return  sh[math.random(#sh)]  
elseif not is_sudo(msg) and w =="هلو" then
return  ns[math.random(#ns)]  
elseif is_sudo(msg) and w == "احبك" then
return  lovs
elseif is_sudo(msg) and w == "تحبني" or w=="حبك"  then
return  lovs
elseif not is_sudo(msg) and w == "احبك" or w=="حبك" then
return  lovm[math.random(#lovm)]  
elseif not is_sudo(msg) and w == "تحبني" then
return  lovm[math.random(#lovm)]  
elseif w== "بوت"  then
return  ss97[math.random(#ss97)]  
elseif w== "غني" or w=="غنيلي" then
return  song[math.random(#song)] 
elseif w=="اتفل" or w=="تفل" then
if is_mod(msg) then return 'ختفوووووووووو💦💦️️' else return "🌟| انجب ما اتفل عيب 😼🙌🏿" end
elseif w== "تف" then
return  "عيب ابني/بتي اتفل/ي اكبر منها شوية 😌😹"
elseif w== "شلونكم" or w== "شلونك" or w== "شونك" or w== "شونكم"   then
return  "احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚"
elseif w== "صاكه"  then
return  "اووويلي يابه 😍❤️ دزلي صورتهه 🐸💔"
elseif w== "وينك"  then
return   "دور بكلبك وتلكاني 😍😍❤️"
elseif w== "منورين"  then
return  "من نورك عمري ❤️🌺"
elseif w== "هاي"  then
return  "هايات عمري 😍🍷"
elseif w== "🙊"  then
return  "فديت الخجول 🙊 😍"
elseif w== "😢"  then
return  "لتبجي حياتي 😢"
elseif w== "😭"  then
return  "لتبجي حياتي 😭😭"
elseif w== "منور"  then
return  "نِْـِْـــِْ([💡])ِْــــًِـًًْـــِْـِْـِْـورِْكِْ"
elseif w== "😒" and not is_sudo then
return  "شبيك-ج عمو 🤔"
elseif w== "مح"  then
return  "محات حياتي🙈❤"
elseif w== "شكرا" or w== "ثكرا" then
return  "{ •• الـّ~ـعـفو •• }"
elseif w== "انته وين"  then
return  "بالــبــ🏠ــيــت"
elseif w== "😍"  then
return  " يَمـه̷̐ إآلُحــ❤ــب يَمـه̷̐ ❤️😍"
elseif w== "اكرهك"  then
return  "ديله شلون اطيق خلقتك اني😾🖖🏿🕷"
elseif w== "اريد اكبل"  then
return  "خخ اني هم اريد اكبل قابل ربي وحد😹🙌️"
elseif w== "باي" or w=="بااي" or w=="باااي" or w=="بااااي" then
return  "بايات حياتي ❤️ " ..name_user.."\n"
elseif w== "ضوجه"  then
return  "شي اكيد الكبل ماكو 😂 لو بعدك/ج مازاحف/ة 🙊😋"
elseif w== "اروح اصلي"  then
return  "انته حافظ سوره الفاتحة😍❤️️"
elseif w== "صاك"  then
return  "زاحفه 😂 منو هذا دزيلي صورهه"
elseif w== "اجيت" or w=="اني اجيت" then
return  "كْـٌﮩٌﮧٌ﴿😍﴾ـﮩٌول الـ୭ـهـٌ୭ـْلا❤️"
elseif w== "طفي السبلت"  then
return  "تم اطفاء السبلت بنجاح 🌚🍃"
elseif w== "شغل السبلت"  then
return  "تم تشغيل السبلت بنجاح بردتو مبردتو معليه  🌚🍃"
elseif w== "اريد بوت"  then
return  "@SuperApi_Bot"
elseif w=="نايمين" then
return  "ني سهران احرسكـم😐🍃'"
elseif w=="اكو احد" then
return  "يي عيني انـي موجـود🌝🌿"
elseif w=="شكو" then
return  "كلشي وكلاشي🐸تگـول عبالك احنـة بالشورجـة🌝"
elseif w=="انتة منو" then
return  "آني كـامل مفيد اكبر زنگين أگعدة عالحديـد🙌"
elseif w=="كلخرا" then
return  "خرا ليترس حلكك/ج ياخرا يابنلخرا خختفووو ابلع😸🙊💋"
elseif w== "حبيبتي"  then
return  "منو هاي 😱 تخوني 😔☹"
elseif w== "حروح اسبح"  then
return  "واخيراً 😂"
elseif w== "😔"  then
return  "ليش الحلو ضايج ❤️🍃"
elseif w== "☹️"  then
return  "لضوج حبيبي 😢❤️🍃"
elseif w== "جوعان"  then
return  "تعال اكلني 😐😂"
elseif w== "تعال خاص" or w== "خاصك" or w=="شوف الخاص" or w=="شوف خاص" then
return  "ها شسون 😉"
elseif w== "لتحجي"  then
return  "وانت شعليك حاجي من حلگگ😒"
elseif w== "معليك" or w== "شعليك" then
return  "عليه ونص 😡"
elseif w== "شدسون" or w== "شداتسوون" or w== "شدتسون" then
return  "نطبخ 😐"
elseif w== "شلونك بوت"  then
return "احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚"
elseif w== "يومه فدوه"  then
return  "فدؤه الج حياتي 😍😙"
elseif w== "افلش"  then
return  "باند عام من 30 بوت 😉"
elseif w== "احبج"  then
return  "يخي احترم شعوري 😢"
elseif w== "شكو ماكو"  then
return  "غيرك/ج بل كلب ماكو يبعد كلبي😍❤️️"
elseif w== "اغير جو"  then
return  "😂 تغير جو لو تسحف 🐍 عل بنات"
elseif w== "😋"  then
return  "طبب لسانك جوه عيب 😌"
elseif w== "😡"  then 
return  "ابرد  🚒"  
elseif w== "مرحبا"  then
return  "مراحب 😍❤️ نورت-ي 🌹"
elseif w== "سلام" or w== "السلام عليكم" or w== "سلام عليكم" or w=="سلامن عليكم" or w=="السلامن عليكم" then
return  "وعليكم السلام اغاتي🌝👋" 
elseif w== "واكف"  then
return  "يخي مابيه شي ليش تتفاول😢" 
elseif w== "🚶🏻"  then
return  "لُـﮩـضڵ تتـمشـﮥ اڪعـد ﺳـﯠڵـف 🤖👋🏻"
elseif w== "البوت واكف"  then
return  "هياتني 😐"
elseif w == "ضايج"  then 
return  "ليش ضايج حياتي"
elseif w== "ضايجه"  then
return  "منو مضوجج كبدايتي"
elseif w== "😳" or w== "😳😳" or w== "😳😳😳" then
--return  "ها بس لا شفت خالتك الشكره 😳😹🕷"
elseif w== "صدك"  then
return  "قابل اجذب عليك!؟ 🌚"
elseif w== "شغال"  then
return  "نعم عزيزي باقي واتمدد 😎🌿"
elseif w== "تخليني"  then
return  "اخليك بزاويه 380 درجه وانته تعرف الباقي 🐸"
elseif w== "فديتك" or w== "فديتنك"  then
return  "فداكـ/چ ثولان العالـم😍😂" 
elseif w== "بوت"  then
return  "انا بوت ستار وارز اقوم بحماية ⚡️ المجموعات بكفاءه عالية 😃"
elseif w== "مساعدة"  then
return  "لعرض اوامر البوت 📝 فقط ارسل الاوامر !"
elseif w== "زاحف"  then
return  "زاحف عله خالتك الشكره 🌝"
elseif w== "حلو"  then
return  "حلو حلو هوايه حلو شكد حلو والله 😂🕸"
elseif w== "تبادل"  then
return  "عليك المكان عليه 🐾"
elseif w== "عاش"  then
return  "الحلو 🌝🌷"
elseif w== "لهله حمبي 😹"  then
return  "أبو الحمامات 🕊🕊"
elseif w== "ورده" or w== "وردة"  then
return  "أنت/ي  عطرها 🌹🌸"
elseif w== "شسمك"  then
return  "مكتوب فوك 🌚🌿"
elseif w== "فديت" or w=="فطيت" then
return  "فداك/ج 💞🌸"
elseif w== "واو"  then
return  "قميل 🌝🌿"
elseif w== "زاحفه" or w== "زاحفة"  then
return  "لو زاحفتلك جان ماكلت زاحفه 🌝🌸"
elseif w== "حبيبي" or w=="حبي"  then
return  "بعد روحي 😍❤️ تفضل"
elseif w== "حبيبتي"  then
return  "تحبك وتحب عليك 🌝🌷"
elseif w== "حياتي"  then
return  "ها حياتي 😍🌿"
elseif w== "عمري"  then
return  "خلصته دياحه وزحف 🌝🌿 "
elseif w== "اسكت"  then
return  "وك معلم 🌚💞"
elseif w== "بتحبني"  then
return  "بحبك اد الكون 😍🌷"
elseif w== "المعزوفه" or w=="المعزوفة" or w=="معزوفه" then
return  "طرطاا طرطاا طرطاا 😂👌"
elseif w== "موجود"  then
return  "تفضل عزيزي 🌝🌸"
elseif w== "اكلك"  then
return  ".كول حياتي 😚🌿"
elseif w== "فدوه" or w=="فدوة" or w=="فطوه" or w=="فطوة" then      
return  "لكلبك/ج 😍❤️"
elseif w== "دي"  then
return  "خليني احہۣۗبہۜۧ😻ہہۖۗڱֆ ̮⇣  🌝💔"
elseif w== "اشكرك"  then
return  "بخدمتك/ج حبي ❤"
elseif w== "😉"  then
return  "😻🙈"
elseif w== "اقرالي دعاء"  then
return "اللهم عذب المدرسين 😢 منهم الاحياء والاموات 😭🔥 اللهم عذب ام الانكليزي 😭💔 وكهربها بلتيار الرئيسي 😇 اللهم عذب ام الرياضيات وحولها الى غساله بطانيات 🙊 اللهم عذب ام الاسلاميه واجعلها بائعة الشاميه 😭🍃 اللهم عذب ام العربي وحولها الى بائعه البلبي اللهم عذب ام الجغرافيه واجعلها كلدجاجه الحافية اللهم عذب ام التاريخ وزحلقها بقشره من البطيخ وارسلها الى المريخ اللهم عذب ام الاحياء واجعلها كل مومياء اللهم عذب المعاون اقتله بلمدرسه بهاون 😂😂😂"
elseif msg.edited and not is_sudo(msg) and settings.lock_edit =="❌" then
return "لزمتك 😂 سحكت وسويت تعديل حمبي 🙌🏽"
-------------- صوتيات
elseif w == "ابجي" then
--send_document(get_receiver(msg), "data/stickers/ebke.webp", ok_cb, false)
elseif w == "اضحك" then
--send_document(get_receiver(msg), funstickers[math.random(#funstickers)], ok_cb, false)
elseif w == "بوت عفط" and ww and msg.reply_id and is_sudo(msg) then
if msg.reply_id then
return tdcli.sendVoice(msg.chat_id_, msg.reply_id, 0, 1, nil, 'data/audio/zeg.ogg', nil, nil, 'اسمع الاغنيه  اسمع 😼')
end
elseif w == "بوت بوس" and ww and msg.reply_id and is_sudo(msg) then
if msg.reply_id then
return tdcli.sendAnimation(msg.to.id, msg.reply_id, 0, 1, nil, "data/photo/bos.mp4", nil, nil, 'مح 💋')  
end
---------------------------------------------
elseif w == "انجب" or w == "نجب" or w=="جب" then
if is_sudo(msg) then 
return   "حاضر تاج راسي انجبيت 😇 "
elseif is_admin1(msg) then
return   " لخاطرك راح اسكت لان ادمن واحترمك 😌"
elseif is_owner(msg) then
return   "لخاطرك راح اسكت لان مدير وع راسي  😌"
elseif is_mod(msg) then
return   "فوك مامصعدك ادمن ؟؟ انته انجب 😏"
else
return   "انجب انته لاتندفر 😏"
end
elseif  data[tostring(msg.to.id)]['replay'] and data[tostring(msg.to.id)]['replay'][w] then
return  data[tostring(msg.to.id)]['replay'][w] 

end
end 
else
return
end
---------------------------------------------
    
---------------------------------------------

end
return {
patterns = {
"^(بوت عفط)(.*)$", 
"^(بوت اتفل)(.*)$", 
"^(بوت رزله)(.*)$", 
"^(بوت بوس)(.*)$", 
"^(تحب) (.*)$",
"^(ستار وارس) (.*)$",
"^(كله) (.*)$",
"^(كول) (.*)$",
"^(بوس) (.*)$", 
"^(رد) (اضف) ([^%s]+) (.+)$",
"^(رد) (مسح الكل)$",
"^(رد) (مسح) (.*)$",
"(.*)" 
},
run = run,
}
end
-- __  __                    _       
--|  \/  | __ _ _ __ ___ ___| | ___  
--| |\/| |/ _` | '__/ __/ _ \ |/ _ \ 
--| |  | | (_| | | | (_|  __/ | (_) |
--|_|  |_|\__,_|_|  \___\___|_|\___/ 
-- BY :- @iiDii Ch :- @Star_Wars