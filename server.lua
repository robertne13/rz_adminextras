--New Script
local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Commands.Add("setname", '(ADMIN ONLY)', {{id = "id", help = 'Player id'}}, false, function(source, args)
--QBCore.Commands.Add('setname', '(ADMIN ONLY)', {{id = "id", help = 'Player id'}}, false, function(source, args)
    local src = source
    if args[1] ~= nil then
        print("^1Cambio nombre: ^0" .. args[1])
        TriggerClientEvent('rz_adminextras:newname', 25)
    else
        print("^1 ERROR AL CAMBIAR NOMBRE ID ERRONEA^0")
    end
end, 'god')

RegisterNetEvent('rz_adminextras:readyname')
AddEventHandler('rz_adminextras:readyname', function(newname, newlast , citizenid)
    local src = source
    local fnew = tostring(newname)
    local lnew = tostring(newlast)
    local license = getIds(src)
    local Player = QBCore.Functions.GetPlayer(src)

    print("^3Nuevo nombre recibido Cambiando en DATABASE FN: ^0" ..tostring(fnew) .. "^3 LN: ^0" .. tostring(lnew) .. "^3 CitID: ^0"..Player.PlayerData.citizenid)
    local playerActualData = {}
    local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {Player.PlayerData.citizenid})
    local PlayerData = result[1]
    local charinfo = json.decode(PlayerData.charinfo)
    print("^1Nombre Actual: ^0" .. charinfo.firstname .. "^1 Apellido actual: ^0" .. charinfo.lastname)
    charinfo.firstname = fnew
    charinfo.lastname = lnew
    charinfo = json.encode(charinfo)
    MySQL.Async.execute('UPDATE players SET charinfo = @charinfo WHERE citizenid = @senderId',
    { ['charinfo'] =  charinfo, ['senderId'] = Player.PlayerData.citizenid },
    function(affectedRows)
     -- print(affectedRows)
    end
    )
end)

function getIds(source)
	local id = GetPlayerIdentifiers(source)
    local license = "ERROR"
    for k,v in ipairs(id)do
		--print ("ID: ".. v)
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		end
	end
    return license
end