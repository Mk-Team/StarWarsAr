-- __  __                    _       
--|  \/  | __ _ _ __ ___ ___| | ___  
--| |\/| |/ _` | '__/ __/ _ \ |/ _ \ 
--| |  | | (_| | | | (_|  __/ | (_) |
--|_|  |_|\__,_|_|  \___\___|_|\___/ 
-- BY :- @iiDii Ch :- @Star_Wars     
do 
local function plugin_enabled( name ) 
  for k,v in pairs(_config.enabled_plugins) do 
    if name == v then 
      return k 
    end 
  end 
  return false 
end 

local function plugin_exists( name ) 
  for k,v in pairs(plugins_names()) do 
    if name..'.lua' == v then 
      return true 
    end 
  end 
  return false 
end 

local function list_all_plugins(only_enabled) 
  local text = '' 
  local nsum = 0 
  for k, v in pairs( plugins_names( )) do  
    local status = '❌' 
    nsum = nsum+1 
    nact = 0 
    -- Check if is enabled 
    for k2, v2 in pairs(_config.enabled_plugins) do 
      if v == v2..'.lua' then 
        status = '☑️' 
      end 
      nact = nact+1 
    end 
    if not only_enabled or status == '☑️' then 
      -- get the name 
      v = string.match (v, "(.*)%.lua") 
      text = text..status..'➟ '..v..'\n' 
    end 
  end 
  local text = 'جميع الملفات 📑\n'..text..'\n> عدد جميع الملفات 🗄 :– ['..nsum..']\n> عدد الملفات المفعلة ✅ :– ['..nact..']\n> عدد الملفات المعطلة ❌ :–['..nsum-nact..']'
  return text 
end 

local function list_plugins(only_enabled) 
  local text = '' 
  local nsum = 0 
  for k, v in pairs( plugins_names( )) do 
    local status = '❌' 
    nsum = nsum+1 
    nact = 0  
    for k2, v2 in pairs(_config.enabled_plugins) do 
      if v == v2..'.lua' then 
        status = '☑️' 
      end 
      nact = nact+1 
    end 
    if not only_enabled or status == '☑️' then 
      v = string.match (v, "(.*)%.lua") 
      text = text..status..'➠ '..v..'\n' 
    end 
  end 
  local text = 'جميع الملفات 📑\n'..text..'\n> عدد جميع الملفات 🗄 :– ['..nsum..']\n> عدد الملفات المفعلة ✅ :– ['..nact..']\n> عدد الملفات المعطلة ❌ :–['..nsum-nact..']'
  return text 
end 

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
  return list_plugins(true) 
end 

local function enable_plugin( plugin_name ) 
  print('checking if '..plugin_name..' exists') 
  if plugin_enabled(plugin_name) then 
    return 'تم تعطيل الملف 📁\n:– '..plugin_name..' ' 
  end 
  if plugin_exists(plugin_name) then 
    table.insert(_config.enabled_plugins, plugin_name) 
    print(plugin_name..' added to _config table') 
    save_config() 
    return reload_plugins( ) 
  else 
    return 'عذراً ℹ️ لايوجد ملف بهذا الاسم  !\n:– '..plugin_name..'' 
  end 
end 

local function disable_plugin( name, chat ) 
  if not plugin_exists(name) then 
    return 'عذراً ℹ️ لايوجد ملف بهذا الاسم  ! \n\n'
  end 
  local k = plugin_enabled(name) 
  if not k then 
    return 'تم تعطيل الملف 📁 بنجاح ✅\n:– '..name..' ' 
  end 
  table.remove(_config.enabled_plugins, k) 
  save_config( ) 
  return reload_plugins(true) 
end 

local function run(msg, matches) 
  if matches[1] == 'الملفات' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
    return list_all_plugins() 
  end 
  if matches[1] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
    local plugin_name = matches[2] 
    print("enable: "..matches[2]) 
    return enable_plugin(plugin_name) 
  end 
  if matches[1] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo 
    if matches[2] == 'plugins'  then 
       return '🛠عود انته لوتي تريد تعطل اوامر التحكم بالملفات 🌚' 
    end 
    print("disable: "..matches[2]) 
    return disable_plugin(matches[2]) 
  end 
  if matches[1] == 'تحديث'  or matches[1]=="we" and is_sudo(msg) then --after changed to moderator mode, set only sudo 
  plugins = {} 
  load_plugins() 
  return "تم اعادة 🔄 تحميل الملفات ✅"
  end 
  ----------------
   if matches[1] == "sp" or matches[1] == "جلب ملف" and is_sudo(msg) then 
     if matches[2]=="الكل" or matches[2]=="all" then
   tdcli.sendMessage(msg.to.id, msg.id, 1, 'انتضر قليلا سوف يتم ارسالك كل الملفات📢', 1, 'html')

  for k, v in pairs( plugins_names( )) do  
      -- get the name 
      v = string.match (v, "(.*)%.lua") 
      		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..v..".lua", '@Star_Wara', dl_cb, nil)

  end 
else
local file = matches[2] 
  if not plugin_exists(file) then 
    return 'عذراً ℹ️ لايوجد ملف بهذا الاسم  ! \n\n'
  else 
tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, "./plugins/"..file..".lua", '@Star_Wars', dl_cb, nil)

return 'انتضر عزيزي \nسـارسـل لـك الـمـلـف '..matches[2]..'\nيـا '..(msg.from.first_name or "erorr")..'\n'
end
end
end
  if matches[1] == "dp" or matches[1] == "حذف ملف"  and matches[2] and is_sudo(msg) then 
    disable_plugin(matches[2]) 
    if disable_plugin(matches[2]) == 'عذراً ℹ️ لايوجد ملف بهذا الاسم  ! \n\n' then
      return 'عذراً ℹ️ لايوجد ملف بهذا الاسم  ! \n\n'
      else
        text = io.popen("rm -rf  plugins/".. matches[2]..".lua"):read('*all') 
  return 'تم حذف الملف \n:-'..matches[2]..'\n يا '..(msg.from.first_name or "erorr")..'\n'
 
        end

end 


end 

return { 
  patterns = { 
    "^الملفات$", 
    "^/p? (+) ([%w_%.%-]+)$", 
    "^/p? (-) ([%w_%.%-]+)$", 
    "^(sp) (.*)$", 
	  "^(dp) (.*)$", 
	  "^(حذف ملف) (.*)$",
  	"^(جلب ملف) (.*)$",
    "^(تحديث)$",
    "^(we)$",
 }, 
  run = run, 
  moderated = true, 
  --privileged = true 
} 

end 
-- __  __                    _       
--|  \/  | __ _ _ __ ___ ___| | ___  
--| |\/| |/ _` | '__/ __/ _ \ |/ _ \ 
--| |  | | (_| | | | (_|  __/ | (_) |
--|_|  |_|\__,_|_|  \___\___|_|\___/ 
-- BY :- @iiDii Ch :- @Star_Wars.    