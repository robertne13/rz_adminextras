--New Script
local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Commands.Add(Config.CommandName, '(ADMIN ONLY)', {{id = "id", help = 'Player id'}}, false, function(source, args)
    local src = source
    if args[1] ~= nil then
        print("^1Cambio nombre: ^0" .. args[1])
        TriggerClientEvent('rz_adminextras:newname', args[1] , src)
    else
        print("^1 ERROR AL CAMBIAR NOMBRE ID ERRONEA^0")
    end
end, 'god')

--not ready
QBCore.Commands.Add("pk", '(ADMIN ONLY)', {{id = "id", help = 'Player id'}}, false, function(source, args)
    local src = source
    if args[1] ~= nil then
        print("^1PK: ^0" .. args[1])
        
    else
        print("^1 ERROR PK ID ERRONEA^0")
    end
end, 'god')

RegisterNetEvent('rz_adminextras:readyname')
AddEventHandler('rz_adminextras:readyname', function(newname, newlast , adminid)
    local src = source
    local fnew = tostring(newname)
    local lnew = tostring(newlast)
    local license = getIds(src)
    local Player = QBCore.Functions.GetPlayer(src)
    local admin = adminid
    print("^3Nuevo nombre recibido Cambiando en DATABASE FN: ^0" ..tostring(fnew) .. "^3 LN: ^0" .. tostring(lnew) .. "^3 CitID: ^0"..Player.PlayerData.citizenid)
    local playerActualData = {}
    local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
    local PlayerData = result[1]
    local charinfo = json.decode(PlayerData.charinfo)
    print("^1Nombre Actual: ^0" .. charinfo.firstname .. "^1 Apellido actual: ^0" .. charinfo.lastname)
    local oldname = charinfo.firstname
    local oldlname = charinfo.lastname
    charinfo.firstname = fnew
    charinfo.lastname = lnew
    charinfo = json.encode(charinfo)
    local msjtosend = '{"content": null,"embeds": [{"title": "Name Change '..GetPlayerName(src)..'", "description": "Admin '..GetPlayerName(admin)..' gives name change to '..GetPlayerName(src)..'\\nOld Name: '..oldname..' ' .. oldlname.. '\\nNew Name: '..fnew.. ' ' .. lnew..'", "color": 9305944, "author": {"name": "AdminExtras"} } ], "attachments": [] }'
    informDiscord(Config.Webhook ,msjtosend)
    DropPlayer(src ,'Su Nombre ha sido cambiado con exito, Ingrese nuevamente al servidor')
    MySQL.Async.execute('UPDATE players SET charinfo = @charinfo WHERE citizenid = @senderId',
    { ['charinfo'] =  charinfo, ['senderId'] = Player.PlayerData.citizenid },
    function(affectedRows)
     -- print(affectedRows)
    end
    )

end)

--not used maybe will be used on esx support future update
function getIds(source)
	local id = GetPlayerIdentifiers(source)
    local license = "ERROR"
    for k,v in ipairs(id)do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		end
	end
    return license
end

function informDiscord(webhook, message)
    if DebugMode then  print("Discord Send: " ..message) end
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', message, { ['Content-Type'] = 'application/json' })
end