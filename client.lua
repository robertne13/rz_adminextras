local QBCore = exports['qb-core']:GetCoreObject()

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
                -- default = "CID-1234", -- Default text option, this is optional
            },
            {
                text = "Apellido", -- text you want to be displayed as a place holder
                name = "lastname", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "password123", -- Default text option, this is optional
            },
        },
    })

    if dialog ~= nil then
        local newfirstname = 'error'
        local newlastname = 'error'
        for k,v in pairs(dialog) do
            local key = trim(k)
            print("::: " ..key .." :::")
            if tostring(key) == 'firstname' then
                newfirstname = v
                print("::: OK :::")
            end
            if tostring(key) == 'lastname' then
                newlastname = v
                print("::: OK2 :::")
            end
        end
        print(newfirstname.." " ..newlastname)
        
        TriggerServerEvent('rz_adminextras:readyname', newfirstname , newlastname)
    end
end)