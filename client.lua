local QBCore = exports['qb-core']:GetCoreObject()
local DebugMode = false

function trim(s)
    return s:match( "^%s*(.-)%s*$" )
 end

RegisterNetEvent('rz_adminextras:newname')
AddEventHandler('rz_adminextras:newname', function()
    print("Cambiar nombre")
    local dialog = exports['qb-input']:ShowInput({
        header = "Cambio de nombre",
        submitText = "Cambiar Nombre",
        inputs = {
            {
                text = "Nombre", -- text you want to be displayed as a place holder
                name = "firstname", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = "Apellido", -- text you want to be displayed as a place holder
                name = "lastname", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
        },
    })

    if dialog ~= nil then
        local newfirstname = 'error'
        local newlastname = 'error'
        for k,v in pairs(dialog) do
            local key = trim(k)
           if DebugMode then print("::: " ..key .." :::") end
            if tostring(key) == 'firstname' then
                newfirstname = v
              if DebugMode then  print("::: OK :::") end
            end
            if tostring(key) == 'lastname' then
                newlastname = v
                if DebugMode then print("::: OK2 :::") end
            end
        end
        if DebugMode then print(newfirstname.." " ..newlastname) end

        TriggerServerEvent('rz_adminextras:readyname', newfirstname , newlastname)
    end
end)