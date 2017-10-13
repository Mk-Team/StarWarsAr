-- __  __                    _       
--|  \/  | __ _ _ __ ___ ___| | ___  
--| |\/| |/ _` | '__/ __/ _ \ |/ _ \ 
--| |  | | (_| | | | (_|  __/ | (_) |
--|_|  |_|\__,_|_|  \___\___|_|\___/ 
-- BY :- @iiDii Ch :- @Star_Wars
local function modadd(msg)

    -- superuser and admins only (because sudo are always has privilege)
if not is_admin(msg) then
return '*>* _انت لست مطور 🚹 عزيزي !_'
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
 return '*>* _المجموعة 🚻 بلتأكيد تم تفعيلها ✅ !_ '

end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      replay ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'no',
          lock_spam = 'yes',
          lock_webpage = 'yes',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
		  lock_join = 'no',
		  lock_edit = 'no',
		  lock_mention = 'yes',
		  num_msg_max = '5',
		  time_check = '2',
          },
   mutes = {
                  mute_forward = 'yes',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'yes',
                  mute_text = 'no',
                  mute_photo = 'no',
                  mute_gif = 'no',
                  mute_location = 'yes',
                  mute_document = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
				  mute_keyboard = 'no',
				  mute_game = 'no',
				  mute_inline = 'no',
				  mute_tgservice = 'no',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)

return "*>* _المجموعة 🚻 :-_* ["..msg.to.title.."]*_ تم تفعيلها  بنجاح ✅ !_"

end

local function modrem(msg)

    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then

        return '*>* _انت لست مطور 🚹 عزيزي !_'
    
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
    return "*>* _المجموعة 🚻 :-_* ["..msg.to.title.."]*_ تم تعطيلها مسبقاً 📴  "
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)

 return "*>* _المجموعة 🚻 :-_* ["..msg.to.title.."]*_ تم تعطيلها بنجاح 📴  !_"

end

local function filter_word(msg, word)

local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then

 return  "*>* _الكلمه_ *"..word.."* _تم اضافة ➕ الى قائمة المنع 🔞 مسبقاً !_"
    
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)

 return  "*>* _الكلمه_ *"..word.."* _تم اضافة ➕ الى قائمة المنع 🔞 بنجاح ✅ !_"
    
end

local function unfilter_word(msg, word)

 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
    
return  "*>* _الكلمه_ *"..word.."* _تم ازالة 🚮 من قائمة المنع 🔞 بنجاح ✅ !_"
     
      else

      return  "*>* _الكلمه_ *"..word.."* _تم ازالة 🚮 من قائمة المنع 🔞 مسبقاً ✅ !_"
      
   end
end

local function modlist(msg)

    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then

    return  "*>* _هذه المجموعه 🚻 ليست من حمايتي ⚡️ !_"
  
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way

return  "*>* _لايوجد 📭 ادمنية في هذا المجموعة🚻 !_"
  
end

   message = 'قائمة الادمنية 🚻 :*\n'

  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)

    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
return  "*>* _هذه المجموعه 🚻 ليست من حمايتي ⚡️_"
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
return  "*>* _لايوجد 📭 مدراء  في هذا المجموعة🚻 !_"
end
   message = 'قائمة المدراء 🚹 :*\n'
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)

local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then

return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _هذه المجموعه 🚻 ليست من حمايتي ⚡️_", 0, "md")
     
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم اضافة ➕ الى القائمة البيضاء 🗒 مسبقاً !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى القائمة البيضاء 🗒 بنجاح ✅ !*', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ازالة 🚮 من القائمة البيضاء 🗒 مسبقاً !*', 0, "md")
       
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ازالة 🚮 من القائمة البيضاء 🗒 بنجاح ✅ !*', 0, "md")
   end

tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *انه بلتأكيد مدير 🚹 المجموعة ✅  !*', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة مدير 🚻 في هذا المجموعة ✅  !*', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد تم رفعة ادمن 🚻 في المجموعة ✅  !*', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم رفعة ادمن 🚻 في هذا المجموعة ✅  !*', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)

    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم ترقيتة مدير 🚹 المجموعة ✅  !*', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 🚮 من ادارة 🔧 المجموعة بنجاح ✅  !*', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم رفعة ادمن 🚻 في المجموعة 🚸  !*', 0, "md")
      
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ "..user_name.." *"..data.id_.."* *تم تنزيلة 🚮 من ادمنية  المجموعة بنجاح ✅  !*', 0, "md")
   
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "ايدي" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else

  return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _لم يتم العثور 🔍 على المستخدم !_", 0, "md")
      
   end
end

local function action_by_username(arg, data)

local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then

    return tdcli.sendMessage(data.chat_id_, "", 0, "*>* هذه المجموعه 🚻 ليست من حمايتي ⚡️", 0, "md")
     
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد من الاعضاء المميزين 🌟 في هذا المجموعة ✅  !*', 0, "md")
      end
   
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة ليصبح عضو مميز 🌟 في هذا المجموعة ✅  !*', 0, "md")
   
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 📥 من  الاعضاء المميزين 🌟 في هذا المجموعة ✅  !*', 0, "md")
      
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 📥 من  الاعضاء المميزين 🌟 في هذا المجموعة ✅  !*', 0, "md")
   
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *انه بلتأكيد مدير 🚹 في هذا المجموعة 🌐  !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة مدير 🚻 لهذا المجموعة بنجاح ✅  !*', 0, "md")
   
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* * بلتأكيد ادمن 🚻 في هذا المجموعة ✅  !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة ادمن 🚻 في هذا المجموعة ✅  !*', 0, "md")
   
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *انه بلتأكيد ليس مدير 👮🏻 في هذا المجموعة 🌐  !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 🚮 من ادارة 🔧 المجموعة بنجاح ✅  !*', 0, "md")
   
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *انه بلتأكيد ليس ادمن 🚻 في هذا المجموعة 🌐  !*', 0, "md")
   
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 🚮 من ادمنية 👥 المجموعة بنجاح ✅  !*', 0, "md")
   
end
   if cmd == "ايدي" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "`"..data.id_.."`", 0, "md")
end

else

  return tdcli.sendMessage(arg.chat_id, "", 0, "* العضو غير موجود 📭*", 0, "md")
      
   end
end

local function action_by_id(arg, data)

local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then

    return tdcli.sendMessage(data.chat_id_, "", 0, "*>* هذه المجموعه 🚻 ليست من حمايتي ⚡️", 0, "md")
     
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد تم ✅ ترقية عضو مميز 🌟 في المجموعة 🚻  !*', 0, "md")
     
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة ليصبح عضو مميز 🌟 في هذا المجموعة ✅  !*', 0, "md")
  
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *ليس  من الاعضاء المميزين 🌟 في هذا المجموعة ✅  !*', 0, "md")
      
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
 
return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيله 🚮  من الاعضاء المميزين 🌟 في هذا المجموعة ✅  !*', 0, "md")
   end

  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد تم ✅ ترقية مدير 🚹 في المجموعة 🚻  !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة ليصبح مدير 🚹 في هذا المجموعة ✅  !*', 0, "md")
   
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد تم ترقية ▫️ ادمن في المجموعة ✅  !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)

   return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم ترقيتة ليصبح ادمن 🚻 في هذا المجموعة ✅  !*', 0, "md")
   
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد لم يتم ❗️ ترقية مدير 🚹 في المجموعة 🚻  !*', 0, "md")
      
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 🚮 من ادارة 🔧 المجموعة بنجاح ✅  !*', 0, "md")
   
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *بلتأكيد لم يتم ترقية 📥ادمن في المجموعة 🚻  !*', 0, "md")
   end
  
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)

return tdcli.sendMessage(arg.chat_id, "", 0, '*>* _المستخدم_ '..user_name..' *'..data.id_..'* *تم تنزيلة 🚮 من ادمنية 👨🏻‍🔧 المجموعة بنجاح ✅  !*', 0, "md")
   
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
username = '*لايوجد*'
end
  
return tdcli.sendMessage(arg.chat_id, 0, 1, '*>* _الايدي_ *[ '..data.id_..' ]* \n*>* _المعرف_ : '..username..'\n*>* _الاسم_ : '..data.first_name_, 1)
   end
 else

  return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو لا يوجد_", 0, "md")
    
  end
else

  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _لم يتم العثور 🔍 على المستخدم !_", 0, "md")
      
   end
end


---------------Lock replay-------------------
local function lock_replay(msg, data, target)
if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end
local replay = data[tostring(target)]["settings"]["replay"] 
if replay == "no" then
return '*>* _الردود📢  بلفعل تم ايقافها 📴 في المجموعة ✅_'
else
data[tostring(target)]["settings"]["replay"] = "no"
save_data(_config.moderation.data, data) 
return '*>* _تم ايقاف   الردود 📢  في هذا المجموعة ✅!_'
end
end

local function unlock_replay(msg, data, target)
 if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end 
local replay = data[tostring(target)]["settings"]["replay"]
 if replay == "yes" then
return '*>* _الردود📢  بلفعل تم تشغيلها 📳 في المجموعة ✅_'
else 
data[tostring(target)]["settings"]["replay"] = "yes"
save_data(_config.moderation.data, data) 
return '*>* _تم تشغيل   📳 الردود 📢  في هذا المجموعة ✅!_ '
end
end

---------------Lock Link-------------------
local function lock_link(msg, data, target)

if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
return '*>* _الررابط 📎  بلتأكيد تم قفلها 🔐 في المجموعة ✅_'
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 الروابط 📎  في هذا المجموعة ✅!_'

end
end

local function unlock_link(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then

return '*>* _الررابط 📎  بلتأكيد تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 

return '*>* _تم فتح  🔓 الروابط 📎  في هذا المجموعة ✅!_'

end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then

return '*>* _التاك #️⃣  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 التاك #️⃣  في هذا المجموعة ✅!_ '

end
end

local function unlock_tag(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end
local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then

return '*>* _التاك #️⃣  بلفعل تم فتحه 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 

return '*>* _تم فتح  🔓 التاك #️⃣  في هذا المجموعة ✅!_'
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 
if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then

return '*>* _التذكير 🔖  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)

return '*>* _تم قفل  🔐 التذكير 🔖 في هذا المجموعة ✅!_ '

end
end

local function unlock_mention(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then

return '*>* _التذكير 🔖 بلفعل تم فتحه 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 

return '*>* _تم فتح  🔓 التذكير 🔖 في هذا المجموعة ✅!_ '

end
end


---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then

return '*>* _التعديل ✏️  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 التعذيل ✏️ في هذا المجموعة ✅!_ '

end
end

local function unlock_edit(msg, data, target)
if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
return '*>* _التعديل ✏️  بلفعل تم فتحه 🔓 في المجموعة ✅_'
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
return '*>* _تم فتح  🔓 التعذيل ✏️ في هذا المجموعة ✅!_ '
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then

return '*>* _الكلايش 📊  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 الكلايش 📊 في هذا المجموعة ✅!_'

end
end

local function unlock_spam(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then

return '*>* _الكلايش 📊  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)

return '*>* _تم فتح  🔓 الكلايش 📊 في هذا المجموعة ✅!_ '

end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then

return '*>* _التكرار 📶  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 التكرار 📶 في هذا المجموعة ✅!_ '

end
end

local function unlock_flood(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then

return '*>* _التكرار 📶  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["flood"] = "no"
save_data(_config.moderation.data, data) 

return '*>* _تم فتح  🔓 التكرار 📶 في هذا المجموعة ✅!_ '

end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then

return '*>* _التكرار 📶  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 البوتات 🤖 في هذا المجموعة ✅!_ '

end
end

local function unlock_bots(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then

return '*>* _البوتات 🤖  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 

return '*>* _تم فتح  🔓 البوتات 🤖 في هذا المجموعة ✅!_ '

end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then

return '*>* _الاضافه ➕  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل  🔐 الاضافة ➕ في هذا المجموعة ✅!_ '

end
end

local function unlock_join(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then

return '*>* _الاضافه ➕  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 

return '*>* _تم فتح  🔓 الاضافة ➕ في هذا المجموعة ✅!_ '

end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then

return '*>* _الماركدون ◼️  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الماركدون  ◼️  في هذا المجموعة ✅!_'

end
end

local function unlock_markdown(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then

return '*>* _الماركدون ◼️  بلفعل تم فتحه 🔓 في المجموعة ✅'

else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الماركدون  ◼️ الاضافة ➕ في هذا المجموعة ✅!_ '

end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then

return '*>* _الويب 🌐  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 صفحات الويب  🌐   في هذا المجموعة ✅!_ '

end
end

local function unlock_webpage(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then

return '*>* _صفحات الويب 🌐  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 صفحات الويب  🌐   في هذا المجموعة ✅!_ '

end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then

return '*>* _التثبيت 📩  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 

return "*>* _تم قفل 🔐 التثبيت 📩   في هذا المجموعة ✅!_\n"

end
end

local function unlock_pin(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
  
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then

return '*>* _التثبيت 📩 بلفعل تم فتحه 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 تثبيت الرسائل 📩 في المجموعة ✅_'

end
end
--------Mutes---------

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "yes" then

return '*>* _الصور المتحركة 🎥  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الصور المتحركة  🎥   في هذا المجموعة ✅!_ '

end
end

local function unmute_gif(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "no" then
return '*>* _الصور المتحركة 🎥  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["mutes"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الصور المتحركة 🎥  في هذا المجموعة ✅!_ '

end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "yes" then

return '*>* _الالعاب 🎮  بلفعل تم فتحها 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الالعاب 🎮 في هذا المجموعة ✅!_\n '

end
end

local function unmute_game(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "no" then

return '*>* _الالعاب 🎮  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["mutes"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)

return '*>* _تم فتح 🔓 الالعاب 🎮 في هذا المجموعة ✅!_ '

end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "yes" then

return '*>* _الانلاين ◻️  بلفعل تم قفلها 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الانلاين ◻️ في هذا المجموعة ✅!_ '

end
end

local function unmute_inline(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "no" then

return '*>* _الانلاين ◻️  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["mutes"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الانلاين ◻️ في هذا المجموعة ✅!_ '

end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 

if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "yes" then
return '*>* _الدردشه 📝  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الدردشه 📝 في هذا المجموعة ✅!_ '

end
end

local function unmute_text(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "no" then

return '*>* _الدردشه 📝  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["mutes"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الدردشه 📝 في هذا المجموعة ✅!_ '

end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "yes" then

return '*>* _الصور 🎑  بلفعل تم قفلها 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الصور 🎆 في هذا المجموعة ✅!_ '

end
end

local function unmute_photo(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "no" then

return '*>* _الصور 🏞  بلفعل تم فتحها 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["mutes"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الصور 🎆 في هذا المجموعة ✅!_ '

end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "yes" then

return '*>* _الفيديو 🎦  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)

return '*>* _تم قفل 🔐 الفيديو 🎦 في هذا المجموعة ✅!_ '

end
end

local function unmute_video(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "no" then

return '*>* _الفيديو 🎦  بلفعل تم فتحه 🔓 في المجموعة ✅_'

else 
data[tostring(target)]["mutes"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الفيديو 🎦  في هذا المجموعة ✅ !_ '
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "yes" then

return '*>* _البصمات 🎙  بلفعل تم قفله 🔐 في المجموعة ✅_'

else
 data[tostring(target)]["mutes"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 البصمات 🎙  في هذا المجموعة ✅ !_ '

end
end

local function unmute_audio(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "no" then

return '*>* _البصمات 🎙  بلفعل تم فتحه 🔓 في المجموعة ✅ !_'

else 
data[tostring(target)]["mutes"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)

return '*>* _تم فتح  🔓 البصمات 🎙 في هذا المجموعة ✅ !_ '

end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "yes" then

return '*>* _الصوت 🔕  بلفعل تم قفله 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_voice"] = "☑️️" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الصوت 🔕  في هذا المجموعة ✅ !_'
end

end

local function unmute_voice(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "❌" then

return '*>* _الصوت 📢  بلفعل تم فتحه 🔓 في المجموعة ✅ !_'

else 
data[tostring(target)]["mutes"]["mute_voice"] = "❌"
 save_data(_config.moderation.data, data)

return '*>* _تم فتح 🔓 الصوت 🔔  في هذا المجموعة ✅ !_ '

end
end
---------------قفل الملصقات-------------------
local function mute_sticker(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "☑️️" then

return '*>* _الملصقات 🚼  بلفعل تم قفلها 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_sticker"] = "☑️️" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الملصقات 🚼  في هذا المجموعة ✅ !_ '

end
end

local function unmute_sticker(msg, data, target)

 if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "❌" then

return '*>* _الملصقات 🚼  بلفعل تم فتحها 🔓 في المجموعة ✅ !_'

else 
data[tostring(target)]["mutes"]["mute_sticker"] = "❌"
 save_data(_config.moderation.data, data)

return '*>* _تم فتح 🔓 الملصقات 🚼  في هذا المجموعة ✅ !_ '
 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "☑️️" then

return '*>* _جهات الاتصال 📞  بلفعل تم قفلها 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_contact"] = "☑️️" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 جهات الاتصال 📞  في هذا المجموعة ✅ !_ '

end
end

local function unmute_contact(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "❌" then

return '*>* _جهات الاتصال 📞  بلفعل تم فتحها 🔓 في المجموعة ✅ !_'

else 
data[tostring(target)]["mutes"]["mute_contact"] = "❌"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 جهات الاتصال 📞  في هذا المجموعة ✅ !_\n*بواسطة :-* '

end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "☑️️" then

return '*>* _اعادة التوجية 🔂  بلفعل تم قفلها 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_forward"] = "☑️️" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 اعادة التوجية 🔂  في هذا المجموعة ✅ !_ '

end
end

local function unmute_forward(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "❌" then
return '*>* _اعادة التوجية 🔂  بلفعل تم فتحها 🔓 في المجموعة ✅ !_'
else 
data[tostring(target)]["mutes"]["mute_forward"] = "❌"
 save_data(_config.moderation.data, data)

return '*>* _تم فتح 🔓 اعادة التوجية 🔂  في هذا المجموعة ✅ !_ '
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "☑️️" then

return '*>* _المواقع 🌐  بلفعل تم قفلها 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_location"] = "☑️️" 
save_data(_config.moderation.data, data)

return '*>* _تم قفل 🔐 المواقع 🌐  في هذا المجموعة ✅ !_ '

end
end

local function unmute_location(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "❌" then

return '*>* _المواقع 🌐  بلفعل تم فتحها 🔓 في المجموعة ✅ !_'

else 
data[tostring(target)]["mutes"]["mute_location"] = "❌"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 المواقع 🌐  في هذا المجموعة ✅ !_ '

end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "yes" then

return '*>* _الملفات 🗂  بلفعل تم قفلها 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الملفات 🗂  في هذا المجموعة ✅ !_ '

end
end

local function unmute_document(msg, data, target)

 if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end
 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "❌" then

return '*>* _الملفات 🗂  بلفعل تم فتحها 🔓 في المجموعة ✅ !_'

else 
data[tostring(target)]["mutes"]["mute_document"] = "❌"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الملفات 🗂  في هذا المجموعة ✅ !_ '

end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "☑️️" then

return '*>* _الاشعارات 📈  بلفعل تم قفلها 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "☑️️" 
save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الاشعارات 📈  في هذا المجموعة ✅ !_ '
end
end

local function unmute_tgservice(msg, data, target)

 if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "❌" then

return '*>* _الاشعارات 📈  بلفعل تم فتحها 🔓 في المجموعة ✅ !_'
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "❌"
 save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الاشعارات 📈  في هذا المجموعة ✅ !_ '

end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 

if not is_mod(msg) then

 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"

end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "☑️️" then

return '*>* _الكيبورد ⌨️  بلفعل تم قفله 🔐 في المجموعة ✅ !_'

else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "☑️️" 
save_data(_config.moderation.data, data) 

return '*>* _تم فتح 🔓 الكيبورد ⌨️  في هذا المجموعة ✅ !_ '

end
end

local function unmute_keyboard(msg, data, target)

 if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "❌" then

return '*>* _الكيبورد ⌨️  بلفعل تم فتحه 🔓 في المجموعة ✅ !_'
 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "❌"
 save_data(_config.moderation.data, data) 

return '*>* _تم قفل 🔐 الكيبورد ⌨️  في هذا المجموعة ✅ !_ '
 
end
end
----------MuteList---------
local function mutes(msg, target) 	

if not is_mod(msg) then
 return "*>* _فقط الادمنية 🚻 يمكنه التحكم في البوت 🤖 !_"
end

local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		

if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "❌"		
end
end

local mutes = data[tostring(target)]["mutes"]
 text = "* اعادات وسائط المجموعة ⚡️:*"
 .."\n*>* قفل المتحركه 🎥: "..mutes.mute_gif
 .."\n*>* قفل الدردشه 🗣: "..mutes.mute_text
 .."\n*>* قفل الانلاين ⬜️: "..mutes.mute_inline
 .."\n*>* قفل الالعاب 🎮: "..mutes.mute_game
 .."\n*>* قفل الصور 🏞: "..mutes.mute_photo
 .."\n*>* قفل الفيديو 🎦: "..mutes.mute_video
 .."\n*>* قفل البصمات 🎙: "..mutes.mute_audio
 .."\n*>* قفل الصوت 🎧: "..mutes.mute_voice
 .."\n*>* قفل الملصقات 🤹🏽‍♀️: "..mutes.mute_sticker
 .."\n*>* قفل الجهات 📞: "..mutes.mute_contact
 .."\n*>* قفل التوجيه 🔄: "..mutes.mute_forward
 .."\n*>* قفل الموقع 🌐: "..mutes.mute_location
 .."\n*>* قفل الملفات 🗂: "..mutes.mute_document
 .."\n*>* قفل الاشعارات 💌: "..mutes.mute_tgservice
 .."\n*>* قفل الكيبورد ⌨️: "..mutes.mute_keyboard
 .."\n\nقناتنا 📢 : @WarsTeam \n"

return  tdcli.sendMessage(msg.to.id, msg.id, 0,text , 0, "md")
end

function group_settings(msg, target) 	

if not is_mod(msg) then

 return "*>* _هذا الامر يخص  الادمنية 🚻 فقط   !_"

end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
	
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "☑️️"		
end
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "☑️️"		
end
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "☑️️"		
end
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "☑️️"		
end
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "☑️️"		
end
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "❌"		
end
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_pin"] then			
data[tostring(target)]["settings"]["lock_pin"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_join"] then			
data[tostring(target)]["settings"]["lock_join"] = "❌"		
end
if not data[tostring(target)]["settings"]["replay"] then			
data[tostring(target)]["settings"]["replay"] = "❌"		
end
if not data[tostring(target)]["settings"]["lock_woring"] then			
data[tostring(target)]["settings"]["lock_woring"] = "❌"		
end
end

if data[tostring(target)]["mutes"] then		

if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "❌"		
end
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "❌"		
end
end

 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
local day = math.floor(expi / 86400) + 1
if expi == -1 then
	expire_date = 'غير محدود'
    elseif day == 1 then
	expire_date = 'يوم واحد' 
	elseif day == 2 then
   	expire_date = 'يومين'
	elseif day == 3 then
   	expire_date = '3 ايام'
   	else
	expire_date = day..' يوم'
end

local settings = data[tostring(target)]["settings"] 
local mutes = data[tostring(target)]["mutes"]

 list_mutes = "*اعدادات المجموعة ⚙️*"
  .."\n--------------------"
 .."\n*>* قفل المتحركه 🎥:- "..mutes.mute_gif
 .."\n*>* قفل الدردشه 🔏:- "..mutes.mute_text
 .."\n*>* قفل الانلاين ⬜️:- "..mutes.mute_inline
 .."\n*>* قفل الالعاب 🎮:- "..mutes.mute_game
 .."\n*>* قفل الصور 🏞:- "..mutes.mute_photo
 .."\n*>* قفل الفيديو 🎦:- "..mutes.mute_video
 .."\n*>* قفل البصمات 🎙:- "..mutes.mute_audio
 .."\n*>* قفل الصوت 🎧:- "..mutes.mute_voice
 .."\n*>* قفل الملصقات 🤹🏽‍♀️:- "..mutes.mute_sticker
 .."\n*>* قفل الجهات 📞:- "..mutes.mute_contact
 .."\n*>* قفل التوجيه 🔄:- "..mutes.mute_forward
 .."\n*>* قفل الموقع 🌐:- "..mutes.mute_location
 .."\n*>* قفل الملفات 🗂:- "..mutes.mute_document
 .."\n*>* قفل الاشعارات 📩:- "..mutes.mute_tgservice
 .."\n*>* قفل الكيبورد ⌨️:- "..mutes.mute_keyboard

.."\n\n⚡️ اعدادات اخرى"
.."\n*>* تشغيل الترحيب 💌:- "..settings.welcome
.."\n*>* تشغيل الردود 📶:- "..settings.replay
.."\n*>* تشغيل التحذير ⛔️:- "..settings.lock_woring

 .." \n\n*>* الاشتراك 💳: "..expire_date
 .."\n--------------------\n"
 .."\n*قناتنا 📢 :-* @WarsTeam"
 .."\n*للتواصل 📨 :-* @WarsSupportBot \n"

 list_settings = "*  الاعدادات الخاصه في المجموعة⚙️*\n "
 .."\n*>* قفل التعديل 📝:- "..settings.lock_edit
 .."\n*>* قفل الروابط 🖇:- "..settings.lock_link
 .."\n*>* قفل الاضافه 🚻:- "..settings.lock_join
 .."\n*>* قفل التاك #️⃣:- "..settings.lock_tag
 .."\n*>* قفل التكرار 🔢:- "..settings.flood
 .."\n*>* قفل الكلايش 📊:- "..settings.lock_spam
 .."\n*>* قفل التذكير 🔔:- "..settings.lock_mention
 .."\n*>* قفل الويب 🌐:- "..settings.lock_webpage
 .."\n*>* قفل الماركدوان ⬛️:- "..settings.lock_markdown
 .."\n*>* قفل التثبيت 📥:- "..settings.lock_pin
 .."\n*>* قفل البوتات 🤖:- "..settings.lock_bots
 .."\n*>* عدد التكرار 🔢:- "..NUM_MSG_MAX
 .."\n*>* عدد المده ⏰:- "..SETCHAR
 .."\n*>* التكرار بالزمن ⏳:- "..TIME_CHECK


return  tdcli.sendMessage(msg.to.id, 1, 0,list_settings.."\n\n"..list_mutes , 0, "md")
end

local function run(msg, matches)

local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "تفعيل" then
return modadd(msg)
end
if matches[1] == "تعطيل" then
return modrem(msg)
end
if not data[tostring(msg.to.id)] then return end
if matches[1] == "ايدي" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
if data.photos_[0] then
local rank
if is_sudo(msg) then
rank = 'انت مطور 🕵🏻 البوت عزيزي !'
elseif is_owner(msg) then
rank = 'انت مدير 🚻المجموعة '
elseif is_admin(msg) then
rank = 'انت اداري 👷🏻 في البوت'
elseif is_mod(msg) then
rank = 'انت ادمن 🚹 في المجموعة'
else
rank = 'انت عضو 👤 في المجموعة'
end
if msg.from.username then
userxn = "@"..(msg.from.username or "---")
else
userxn = "لا يتوفر"
end
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)

tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'> اسمك 📄:- '..msg.from.first_name..'\n> معرفك 🚹:- '..userxn..'\n> ايديك 🆔:- '..msg.from.id..'\n> رتبتك 🌐:- '..rank..'\n> عدد رسائلك 📩:- ['..msgs..'] رسالة \n> قناتنا 📢:- @WarsTeam',dl_cb,nil)
   else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "*لا توجد صورة 📭 في ملفك الشخصي !*\n\n *>* _ايدي المجموعة 🚻 :-_ *"..msg.to.id.."*\n*>* _ايديك 🚹 :-_ *"..msg.from.id.."*", 1, 'md')
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ايدي"})
  end
if matches[2] and is_mod(msg) then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ايدي"})
      end
   end
if matches[1] == "تثبيت" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '☑️️' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)

return "*>* _تم تثبيت 📩 الرسالة بنجاح ✅_"

elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == '❌' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)

return "*>* _تم تثبيت 📩 الرسالة بنجاح ✅_"

end
end
if matches[1] == "الغاء التثبيت" and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '☑️️' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
return "*>* _تم الغاء تثبيت 📩 الرسالة بنجاح ❌_"

elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == '❌' then
tdcli.unpinChannelMessage(msg.to.id)

return "*>* _تم الغاء تثبيت 📩 الرسالة بنجاح ❌_"

end
end

if matches[1] == "رفع عضو مميز" and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setwhitelist"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setwhitelist"})
      end
   end
if matches[1] == "تنزيل عضو مميز" and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remwhitelist"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remwhitelist"})
      end
end

if matches[1] == "رفع المدير" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "تنزيل المدير" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "رفع ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "تنزيل ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الروابط" then
return lock_link(msg, data, target)
end
if matches[2] == "التاك" then
return lock_tag(msg, data, target)
end
if matches[2] == "التذكير" then
return lock_mention(msg, data, target)
end
if matches[2] == "التعديل" then
return lock_edit(msg, data, target)
end
if matches[2] == "الكلايش" then
return lock_spam(msg, data, target)
end
if matches[2] == "التكرار" then
return lock_flood(msg, data, target)
end
if matches[2] == "البوتات" then
return lock_bots(msg, data, target)
end
if matches[2] == "الماركدوان" then
return lock_markdown(msg, data, target)
end
if matches[2] == "الويب" then
return lock_webpage(msg, data, target)
end
if matches[2] == "الثبيت" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "الاضافه" then
return lock_join(msg, data, target)
end
end
if matches[1] == "فتح" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الروابط" then
return unlock_link(msg, data, target)
end
if matches[2] == "التاك" then
return unlock_tag(msg, data, target)
end
if matches[2] == "التذكير" then
return unlock_mention(msg, data, target)
end
if matches[2] == "التعديل" then
return unlock_edit(msg, data, target)
end
if matches[2] == "الكلايش" then
return unlock_spam(msg, data, target)
end
if matches[2] == "التكرار" then
return unlock_flood(msg, data, target)
end
if matches[2] == "البوتات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "الماركوان" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "الويب" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "التثبيت" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "الاضافه" then
return unlock_join(msg, data, target)
end
end

if matches[1] == "قفل" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الكل" then
    local close_all ={
 mute_gif(msg, data, target),
 mute_photo(msg ,data, target),
 mute_audio(msg ,data, target),
 mute_voice(msg ,data, target),
 mute_sticker(msg ,data, target),
 mute_forward(msg ,data, target),
 mute_contact(msg ,data, target),
 mute_location(msg ,data, target),
 mute_document(msg ,data, target),
 mute_inline(msg ,data, target),
 lock_link(msg, data, target),
 lock_tag(msg, data, target),
 lock_mention(msg, data, target),
 lock_edit(msg, data, target),
 lock_spam(msg, data, target),
 lock_bots(msg, data, target),
 lock_webpage(msg, data, target),
 mute_video(msg ,data, target),
    }
 local text =  '*>* تم قفل 🔐 جميع الوسائط 🔕 في المجموعة ✅'
 tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return close_all
end
if matches[2] == "المتحركه" then
return mute_gif(msg, data, target)
end
if matches[2] == "الدردشه" then
return mute_text(msg ,data, target)
end
if matches[2] == "الصور" then
return mute_photo(msg ,data, target)
end
if matches[2] == "الفيديو" then
return mute_video(msg ,data, target)
end
if matches[2] == "البصمات" then
return mute_audio(msg ,data, target)
end
if matches[2] == "الصوت" then
return mute_voice(msg ,data, target)
end
if matches[2] == "الملصقات" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "الجهات" then
return mute_contact(msg ,data, target)
end
if matches[2] == "التوجيه" then
return mute_forward(msg ,data, target)
end
if matches[2] == "الموقع" then
return mute_location(msg ,data, target)
end
if matches[2] == "الملفات" then
return mute_document(msg ,data, target)
end
if matches[2] == "الاشعارات" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "الانلاين" then
return mute_inline(msg ,data, target)
end
if matches[2] == "الالعاب" then
return mute_game(msg ,data, target)
end
if matches[2] == "الكيبورد" then
return mute_keyboard(msg ,data, target)
end
end
if matches[1] == "فتح" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الكل" then
    local open_all ={
 unmute_gif(msg, data, target),
 unmute_photo(msg ,data, target),
 unmute_audio(msg ,data, target),
 unmute_voice(msg ,data, target),
 unmute_sticker(msg ,data, target),
 unmute_forward(msg ,data, target),
 unmute_contact(msg ,data, target),
 unmute_location(msg ,data, target),
 unmute_document(msg ,data, target),
 unlock_link(msg, data, target),
 unlock_tag(msg, data, target),
 unlock_mention(msg, data, target),
 unlock_edit(msg, data, target),
 unlock_spam(msg, data, target),
 unlock_bots(msg, data, target),
 unlock_webpage(msg, data, target),
 unmute_video(msg ,data, target),
 unmute_inline(msg ,data, target)
    }
    
    local text =  '*>* تم فتح 🔓 جميع الوسائط 🔔 في المجموعة ✅' 
tdcli.sendMessage(msg.to.id, msg.id, 1, text, 0, "md")    
return open_all
end
if matches[2] == "المتحركه" then
return unmute_gif(msg, data, target)
end
if matches[2] == "الدردشه" then
return unmute_text(msg, data, target)
end
if matches[2] == "الصور" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "الفيديو" then
return unmute_video(msg ,data, target)
end
if matches[2] == "البصمات" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "الصوت" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "الملصقات" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "الجهات" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "التوجيه" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "الموقع" then
return unmute_location(msg ,data, target)
end
if matches[2] == "الملفات" then
return unmute_document(msg ,data, target)
end
if matches[2] == "الاشعارات" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "الانلاين" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "الالعاب" then
return unmute_game(msg ,data, target)
end
if matches[2] == "الكيبورد" then
return unmute_keyboard(msg ,data, target)
end
end
if matches[1] == "المجموعه" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)

ginfo = "*معلومات المجموعة ℹ️*\n*>* _عدد الادمنيه _*["..data.administrator_count_.."]*\n*>*_عدد الاعضاء _*["..data.member_count_.."]*\n*>* _عدد المطرودين _*["..data.kicked_count_.."]*\n*>* _ايدي المجموعه _*["..data.channel_.id_.."]*\n*_________________*\n*قناتنا 📢 :-* @WarsTeam"

        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'تغير الرابط' and is_mod(msg) then
			local function callback_link (arg, data)

    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)

       return tdcli.sendMessage(msg.to.id, msg.id, 1, "* ➕ البوت ليس منشئ المجموعة قم بأضافة الرابط 📎 بأرسال* _[ ضع رابط ]_ !", 1, 'md')
    
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
  
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*>* _تم حفظ الرابط 📫 بنجاح شكراً لك ✅ !_", 1, 'md')
            
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
if matches[1] == "ضع رابط" and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)

return "*>* _من فضلك عزيزي 😁 ارسل 📥 الرابط الان 📎 !_"
       
		end

if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)

return "*>* _تم حفظ الرابط 📫 بنجاح شكراً لك ✅ !_"
		 	
       end
		end
		
if matches[1] == "الرابط" and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
 if not linkgp then
return "*>* _ عذراً ليس 📭 هناك رابط 📎 في المجموعة 🚻\nلاضافة ➕ رابط فقط ارسل_ *ضع رابط* !"
      end
      text = "<b>> رابط المجموعة :-</b>\n"..linkgp
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
     
if matches[1] == "الرابط خاص" and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
 
return "*>* _ عذراً ليس 📭 هناك رابط 📎 في المجموعة 🚻\nلاضافة ➕ رابط فقط ارسل_ *ضع رابط* !"
      
      end
      tdcli.sendMessage(msg.from.id, 0, 1, "<code>> رابـط المجموعة 🚻:- \n"..ms.g.to.title.." :\n\n</code>"..linkgp..'\n', 1, 'html')
return "*>* عزيزي 😁 تم ارسال الرابط في الخاص 📥 بنجاح ✅ !"
        
     end

if matches[1] == "ضع قوانين" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)

return '*>* *تم حفظ القوانين 📝 بنجاح ✅*\n_ارسل كلمة  (القوانين) ليتم عرض قوانين 📄 المجموعة 🚻 !_'
   
  end
  if matches[1] == "القوانين" then
 if not data[tostring(chat)]['rules'] then

     rules = "*>* _مرحبأ عزيري_ 😃 _القوانين كلاتي_ 👇🏻\n• _ممنوع نشر الروابط_ \n• _ممنوع التكلم او نشر صور اباحيه_ \n• _ممنوع  اعاده توجيه_ \n• _ممنوع التكلم بلطائفه_ \n• _الرجاء احترام المدراء والادمنيه _🚻 "
 
        else
     rules = "*>* القوانين :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end


  if matches[1] == "ضع تكرار" and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "*>* _حدود التكرار 🔢 يجب ان تكون بين _ * 2 - 50* "
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)

    return "*>* _تم وضع عدد التكرار 🔢 :-_ *[ "..matches[2].." ]*"
    
       end
  if matches[1] == "ضع تكرار بالزمن" and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "*>* _حدود التكرار 🔢 يجب ان تكون بين _ * 2 - 10* "
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)

    return "*>* _تم وضع عدد التكرار 🔢 :-_ *[ "..matches[2].." ]*"
    
       end
		if matches[1] == "مسح" and is_owner(msg) then
			if matches[2] == "الادمنيه" then
				if next(data[tostring(chat)]['mods']) == nil then

return "*>* _عذاً ℹ️ ليس هناك ادمنية في عذا المجموعة 🚻 !_"
				
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
 
return "*>* _تم حذف 🚮 جميع الادمنية 🚻 في هذا المجموعة بنجاح ✅ !_"
			
         end
			if matches[2] == "قائمه المنع" then
				if next(data[tostring(chat)]['filterlist']) == nil then

					return "*>* _قائمة المنع فارغة 📭 عزيزي لايمكنك حذفها 🚮_"
             
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end

				return "*تم حذف 🚮 جميع الكلمات 🔞 الممنوعه بنجاح ✅*"
           
			end
			if matches[2] == "القوانين" then
				if not data[tostring(chat)]['rules'] then
         					

return "*>* _ليس هناك قوانين 💌 ليتم حذفها 🚮_"
             
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)

return "*تم حذف 🚮 قوانين 📃 المجموعة بنجاح ✅*"
			
       end
			if matches[2] == "الترحيب"  then
				if not data[tostring(chat)]['setwelcome'] then
    
return "*>* _عدراً عزيزي لايوجد ترحيب 💌 ليتم حذفه 🚮 !_"
             
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)

return "*تم حذف 🚮 ترحيب 💌 المجموعة بنجاح ✅*"
			
       end
			if matches[2] == "الوصف" then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then

return "*>* _عذراً ليس هناك وصف 📬 ليتم حذفة 🚮 !_"
          
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end

return "*تم حذف 🚮 وصف 📭 المجموعة بنجاح ✅ !*"
             
		   	end
        end
		if matches[1] == "مسح" and is_admin(msg) then
			if matches[2] == "المدراء" then
				if next(data[tostring(chat)]['owners']) == nil then

return "*>* _لايوجد مدراء 🚻 في المجموعة ليتم حذفهم 🚮 !_"
            
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end

            return "*تم حذف 🚮 جميع المدراء 🚻 بنجاح ✅ !*"
          
			end
     end
if matches[1] == "ضع اسم" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "ضع وصف" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end

     return "*تم وضع وصف 📬 للمجموعة بنجاح ✅*"
      
  end
  if matches[1] == "الوصف" and msg.to.type == "chat" and is_owner(msg) then
 if not data[tostring(chat)]['about'] then

      about = "*لا يوجد هناك وصف 📭 في هذا المجموعة 🚻 *!"
       
        else
     about = "*>* _وصف المجموعة 🚻 :-_\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == "منع" and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == "الغاء منع" and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == "قائمه المنع" and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "الاعدادات" and is_mod(msg) then
return group_settings(msg, target)
end
if matches[1] == "الوسائط" and is_mod(msg) then
return mutes(msg, target)
end
if matches[1] == "الادمنيه" and is_mod(msg) then
return modlist(msg)
end
if matches[1] == "المدراء" and is_owner(msg) then
return ownerlist(msg)
end
if matches[1] == "الاعضاء المميزين" and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if matches[1] == "طرد البوتات" and not matches[2] and is_owner(msg) then
  function delbots(arg, data)
  local deleted = 0 
    for k, v in pairs(data.members_) do
      kick_user(v.user_id_, msg.to.id)
	  deleted = deleted + 1 

	end
	if deleted == 0 then
	tdcli.sendMessage(msg.to.id, msg.id, 1, '*>* _لاتوجد بوتات 🤖 في هذا المجموعة ℹ️_', 1, 'md')
	else
tdcli.sendMessage(msg.to.id, msg.id, 1, '*>* تم طرد [*'..deleted..'*] البوت من المجموعة 🚻 بنجاح ✅', 1, 'md')
	end
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, delbots, nil)
end

if matches[1] == "كشف البوتات" and not matches[2] and is_owner(msg) then
  function kshf(arg, data)
  local i = 0
    for k, v in pairs(data.members_) do
     i = i + 1
	end
	if i == 0 then
	tdcli.sendMessage(msg.to.id, msg.id, 1, '*>* _لاتوجد بوتات 🤖 في هذا المجموعة ℹ️_', 1, 'md')
	else
    tdcli.sendMessage(msg.to.id, msg.id, 1, '*>* عدد البوتات 🤖 الموجودة في المجموعة :-  [*'..i..'*] بوت ✅',1, 'md')
	end
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, kshf, nil)
end

if matches[1] == "==" and not matches[2] and is_owner(msg) then

local function alss(arg, data)
local textx = '' 
local i = 1
for k,v in pairs(data.members_) do
local function cbuser(arg,data)
    textx = arg.textx..arg.i.." - @"..data.username_.."  ["..data.id_.."]\n"
end
tdcli_function ({ID = "GetUser",user_id_ = v.user_id_,},cbuser,{i=i,textx=textx})
 i = i +1
end
return tdcli.sendMessage(arg.chat_id, 0, 1, textx, 1, 'html')
end
tdcli.getChannelMembers(msg.to.id, 0,'Recent', 200, alss, {chat_id=msg.to.id,msg_id=msg.id})
end

if matches[1]== 'رسائلي' or matches[1]=='رسايلي' then
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)
return '*>* عدد رسائلك المرسله : [`'..msgs..'`] رساله \n\n'
 end
if matches[1]:lower() == 'معلوماتي' or matches[1]:lower() == 'موقعي'  then
if msg.from.first_name then
if msg.from.username then username = '@'..msg.from.username
else username = '<i>ليس لديك معرف !</i>'
end

if is_sudo(msg) then rank = 'انته هوه مطور 👨🏻‍🔧 البوت'
elseif is_owner(msg) then rank = 'انته مدير 🚻 المجموعة'
elseif is_admin(msg) then rank = 'انته اداري 🔧 في المجموعة !'
elseif is_mod(msg) then rank = 'انته ادمن 👷🏻 في هذا المجموعة !'
else rank = 'انت عضو 🚹 في المجموعة !'
end
local text = '* المعلومات ℹ️ الخاص بك  :*\n\n*> الاسم الاول * _'..msg.from.first_name
..'_\n*> الاسم الثاني 🚹:*_'..(msg.from.last_name  or "---")
..'_\n*> المعرف📄:* '..username
..'\n*> الايدي 🆔:* [*'..msg.from.id
..'* ]\n*> ايدي المجموعة 🚻:* [ *'..msg.to.id
..'* ]\n*> موقعك 🌐:*'..rank
..'\n*>* قناتنا 📢:- @WarsTeam'
tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end
end


--------------------- Welcome -----------------------
if matches[1] == "تشغيل" and is_mod(msg) then
	    local target = msg.to.id
        if matches[2] == "الردود" then
return unlock_replay(msg, data, target)
end
if matches[2] == "الترحيب" then
			welcome = data[tostring(chat)]['settings']['welcome']
		if welcome == "☑️️" then
return "*>* _تم تشغيل الترحيب 💌 مسبقاً ✅_"
			else
		data[tostring(chat)]['settings']['welcome'] = "☑️️"
	    save_data(_config.moderation.data, data)
return "*>* _تم تشغيل الترحيب 💌 بنجاح ✅_"
		end
	end
	if matches[2] == "التحذير" then
			lock_woring = data[tostring(chat)]['settings']['lock_woring']
		if lock_woring == "☑️️" then
return "*>* _تم تشغيل التحذير 📵 مسبقاً ✅_"
			else
		data[tostring(chat)]['settings']['lock_woring'] = "☑️️"
	    save_data(_config.moderation.data, data)
return "*>* _تم تشغيل التحذير 📵 بنجاح ✅_"
		end
		end
		end
if matches[1] == "ايقاف" and is_mod(msg) then
	    local target = msg.to.id
        if matches[2] == "الردود" then
        return lock_replay(msg, data, target)
        end
         if matches[2] == "الترحيب" then
    welcome = data[tostring(chat)]['settings']['welcome']
	if welcome == "❌" then
	return "*>* تم ايقاف الترحيب 💌 مسبقاً ❌"
			else
		data[tostring(chat)]['settings']['welcome'] = "❌"
	    save_data(_config.moderation.data, data)
return "*>* تم ايقاف الترحيب 💌 بنجاح ❌"
			end
end

      if matches[2] == "التحذير" then
    lock_woring = data[tostring(chat)]['settings']['lock_woring']
	if lock_woring == "❌" then
	return "*>* تم ايقاف التحذير 📵 مسبقاً ❌"
			else
		data[tostring(chat)]['settings']['lock_woring'] = "❌"
	    save_data(_config.moderation.data, data)
return "*>* تم ايقاف التحذير 📵 بنجاح ❌"
			end
	end
	end
if matches[1] == "ضع الترحيب" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
		return "*>* _تم وضع الترحيب 💌 بنجاح كلاتي 👋🏻_\n*"..matches[2].."*\n\n*>* _ملاحظه_\n*>* _تستطيع اضهار القوانين بواسطه _ :- *{rules}*  \n*>* _تستطيع اضهار الاسم بواسطه_ :- *{name}*\n*>* _تستطيع اضهار المعرف بواسطه_ :- *{username}*"
	end
if matches[1] == "الترحيب"  and is_mod(msg) then
		if data[tostring(chat)]['setwelcome']  then
	    return data[tostring(chat)]['setwelcome']  
	    else
		return "اهلا بك عزيزي 😃 في المجموعة 💌\nالرجاء الالتزام في قوانين المجموعة 📑\n"
	end
	end
end
end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
return tdcli.sendMessage(msg.to.id, 0, 1, '*>*  البوت ليس ادمن في المجموعة 🚻 من فضلك 😄 يرجى ترقيتة ادمن لكي يقوم بلعمل ⚡️ !', 1, "md")
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://irapi.ir/time/')
          if res ~= 200 then return "فشل الاتصال" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
		welcome = "اهلا بك عزيزي 😃 في المجموعة 💌\nالرجاء الالتزام في قوانين المجموعة 📑\nقناتنا :-م :- @WarsTeam"
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
     rules = "*>* _مرحبأ عزيري_ 😃 _القوانين كلاتي_ 👇🏻\n*>* _ممنوع نشر الروابط_ \n*>* _ممنوع التكلم او نشر صور اباحيه_ \n*>* _ممنوع  اعاده توجيه_ \n*>* _ممنوع التكلم بلطائفه_ \n*>* _الرجاء احترام المدراء والادمنيه _🚻\n*>* _قناتنا 📢:-_ @Star_Wars"

end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	    
	    
if msg.adduser then


		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "☑️️" and msg.adduser ~= tonumber(our_id) then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then

		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "☑️️" and msg.adduser ~= tonumber(our_id) then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
 
return {
patterns ={
"^(ايدي)$",
"^(ايدي) (.*)$",
'^(الاعدادات)$',
'^(الوسائط)$',
'^(تثبيت)$',
'^(الغاء التثبيت)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(رفع المدير)$',
'^(رفع المدير) (.*)$',
'^(تنزيل المير) (.*)$',
'^(تنزيل المدير)$',
'^(رفع عضو مميز) (.*)$',
'^(تنزيل عضو مميز) (.*)$',
'^(رفع عضو مميز)$',
'^(تنزيل عضو مميز)$',
'^(الاعضاء المميزين)$',
'^(رفع ادمن)$',
'^(رفع ادمن) (.*)$',
'^(تنزيل ادمن) (.*)$',
'^(تنزيل ادمن)$',
'^(رفع المدير)$',
'^(رفع المدير) (.*)$',
'^(تنزيل المدير)$',
'^(تنزيل المدير) (.*)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
'^(تشغيل) (.*)$',
'^(ايقاف) (.*)$',
'^(الرابط خاص)$',
'^(تغير الرابط)$',
'^(المجموعه)$',
"^(رسائلي)$",
"^(رسايلي)$",
"^(معلوماتي)$",
"^(موقعي)$",
'^(القوانين)$',
'^(الرابط)$',
'^(ضع رابط)$',
'^(ضع قوانين) (.*)$',
'^(ضع تكرار) (%d+)$',
'^(ضع تكرار) (%d+)$',
'^(ضع تكرار بالزمن) (%d+)$',
'^(مسح) (.*)$',
'^(الوصف)$',
'^(ضع وصف) (.*)$',
'^(قائمه المنع)$',
'^(المدراء)$',
'^(الادمنيه)$',
'^(طرد البوتات)$',
'^(==)$',
'^(كشف البوتات)$',
'^(منع) (.*)$',
'^(الغاء منع) (.*)$',
'^(ضع الترحيب) (.*)$',
'^(الترحيب)$',
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^!!tgservice (.+)$",
},
run=run,
pre_process = pre_process
}
