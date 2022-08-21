local QBCore = exports['qb-core']:GetCoreObject();
local isBusy = false
local copsCalled = false
local Player = {}
local isCooldown = false
local hasItem = false

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

function chanceGet(chance)
    local roll = math.random(1, 100)
    if roll <= chance then 
        return true
    end
    return false
end


CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.Models.laptopmodel, {
        options = {
            {
                event = 'cosmos-lester:client:ThermiteHack',
                type = 'client',
                icon = "fas fa-laptop",
                label = "Get some rewards",
            },
        },
        distance = Config.Distance,
    })
end)


function ThermiteHack()
    exports["memorygame"]:thermiteminigame(8, 2, 3.5, 7,
        function() -- success

            QBCore.Functions.Notify('The next step has been marked on your gps', "success")
        end,
        function() -- failure
            QBCore.Functions.Notify("You failed", "error")
        end)
end

RegisterNetEvent('cosmos-lester:client:ThermiteHack')
AddEventHandler('cosmos-lester:client:ThermiteHack', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if isCooldown == true then
            hasItem = false
            print("On Cooldown")
            QBCore.Functions.Notify("System on cooldown for "..math.floor(Config.CoolDown).. " minutes please come back later")
            Citizen.Wait(Config.Cooling)
            isCooldown = false 
        end
        if hasItem == true then
            exports['ps-dispatch']:LesterHeist()
            exports["memorygame"]:thermiteminigame(8, 2, 3.5, 7,
            function() --success
                local blips = {
                    {title = "??", colour = 2, id = 1, random}
                }
                local coords = Config.Locations[math.random(#Config.Locations)]
                local hash = GetHashKey("Stockade3")
                local vehicle = QBCore.Functions.SpawnVehicle('Stockade3', function(veh)
                    SetEntityHeading(veh, coords.w)
                    SetVehicleNumberPlateText(veh, 'LESTER')
                    SetVehicleColours(veh, 27, 0)
                    SetEntityAsMissionEntity(veh, true, true)
                    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.TruckItems)
                    exports[Config.Fuel]:SetFuel(veh, 100.0)
                    local vehcoords = GetEntityCoords(veh)
                    SetNewWaypoint(vehcoords)
                end, coords, true)
                QBCore.Functions.Notify('Vehicle Successfully Spawned', 'success', 7500) -- success
                isCooldown = true
                print("Now on Cooldown for " ..math.floor(Config.CoolDown).. " minutes")
            end,
            function() -- failure
                QBCore.Functions.Notify("You failed", "error")
            end)
        else 
            QBCore.Functions.Notify("You are missing something", "error")
        end
    end, "trojan_usb")
end)
