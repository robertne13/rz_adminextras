--New Script
local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Commands.Add("setname", '(ADMIN ONLY)', {{id = "id", help = 'Player id'}}, false, function(source, args)
--QBCore.Commands.Add('setname', '(ADMIN ONLY)', {{id = "id", help = 'Player id'}}, false, function(source, args)
    local src = source
    if args[1] ~= nil then
        print("Cambio nombre: " .. args[1])
        TriggerClientEvent('rz_adminextras:newname', 25)
    else
        print("^1 ERROR AL CAMBIAR NOMBRE ID ERRONEA^0")
    end
end, 'god')