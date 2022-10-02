local QBCore = exports['qb-core']:GetCoreObject()



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
        local finalname = {}
        for k,v in pairs(dialog) do
            finalname.k = v
            print(k .. " : " .. v)
        end
        TriggerServerEvent('rz_adminextras:readyname', finalname)
    end
end)