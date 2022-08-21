local QBCore = exports['qb-core']:GetCoreObject();
local isBusy = false
local copsCalled = false
local Player = {}
local isCooldown = false
local hasItem = false
local Locations = {
    vector4(-580.9742, -1119.274, 22.178577, 84.29058),
    vector4(-682.0448, -878.4678, 24.499057, 180.86965),
    vector4(-1018.592, -1007.149, 2.1032044, 115.95909),
    vector4(-1163.437, -2055.085, 14.145155, 324.11349),
    vector4(-767.6372, -2602.057, 13.84762, 232.90646),
    vector4(866.77465, -3020.203, 5.8709816, 272.15036),
    vector4(1638.7873, -2275.123, 106.16671, 4.5649113),
    vector4(1306.4942, -1749.682, 53.878448, 22.562105),
    vector4(755.53625, -306.0304, 59.881511, 301.2843),
    vector4(808.15509, 1272.6915, 360.48495, 264.75378),
    vector4(118.9, -1069.41, 28.72, 359.57)
}

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)


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
                local coords = Locations[math.random(#Locations)]
                local hash = GetHashKey("Stockade3")
                local vehicle = QBCore.Functions.SpawnVehicle('Stockade3', function(veh)
                    SetEntityHeading(veh, coords.w)
                    SetVehicleNumberPlateText(veh, 'LESTER')
                    SetVehicleColours(veh, 27, 0)
                    SetEntityAsMissionEntity(veh, true, true)
                    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.TruckItems)
                    exports['lj-fuel']:SetFuel(veh, 100.0)
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


-- else if hasItem == false then
--QBCore.Functions.Notify("You are missing something", "error")
--end
