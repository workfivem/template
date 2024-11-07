RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(_, _, skin)
    TriggerServerEvent("esx_skin:setWeight", skin)
end)

AddEventHandler("esx_skin:resetFirstSpawn", function()
    firstSpawn = true
    ESX.PlayerLoaded = false
end)

AddEventHandler("esx_skin:playerRegistered", function()
    CreateThread(function()
        while not ESX.PlayerLoaded do
            Wait(100)
        end

        if firstSpawn then
            ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                if skin == nil then
                    -- todo
                    Wait(100)
                else
                    TriggerEvent("skinchanger:loadSkin", skin)
                    Wait(100)
                end
            end)

            firstSpawn = false
        end
    end)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function()
    ESX.PlayerLoaded = true
end)

AddEventHandler("esx_skin:getLastSkin", function(cb)
    cb(lastSkin)
end)
AddEventHandler("esx_skin:setLastSkin", function(skin)
    lastSkin = skin
end)

RegisterNetEvent("esx_skin:requestSaveSkin")
AddEventHandler("esx_skin:requestSaveSkin", function()
    TriggerEvent("skinchanger:getSkin", function(skin)
        TriggerServerEvent("esx_skin:responseSaveSkin", skin)
    end)
end)
