local QBCore = exports['qb-core']:GetCoreObject();
local isBusy = false
local copsCalled = false
local Player = {}
local isCooldown = false
local hasItem = false
local truckHackActive = false
local disableHacking = false 
local spot = vector3(956.34069, -1570.543, 30.640806)
QBCore.Commands = {}
QBCore.Commands.List = {}

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
            copsCalled = true
            exports["memorygame"]:thermiteminigame(8, 2, 3.5, 7,
            function() --success
                local blips = {
                    {title = "??", colour = 2, id = 1, random}
                }
                local coords = Config.Locations[math.random(#Config.Locations)]
                local hash = GetHashKey("Stockade3")
                vehicle = QBCore.Functions.SpawnVehicle('Stockade3', function(veh)
                    SetEntityHeading(veh, coords.w)
                    SetVehicleNumberPlateText(veh, 'LESTER')
                    SetVehicleColours(veh, 27, 0)
                    SetEntityAsMissionEntity(veh, true, true)
                    SetVehicleDoorsLocked(veh, 3)
                    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.TruckItems)
                    exports[Config.Fuel]:SetFuel(veh, 100.0)
                    vehcoords = GetEntityCoords(veh)
                    SetNewWaypoint(spot)
                end, coords, true)
                QBCore.Functions.Notify('Follow the marker on your gps', 'success', 7500) -- success
                isCooldown = true
                TriggerServerEvent('cosmos-lester:sever:PlayerCooldown')
                TriggerEvent('cosmos-lester:server:isHacked')
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

RegisterNetEvent('cosmos-lester:server:isHacked')
AddEventHandler('cosmos-lester:server:isHacked', function()
    if isCooldown == true then
    CreateThread(function()
        exports['qb-target']:AddTargetModel(Config.Models.backdoormodel, {
            options = {
                {
                    event = 'cosmos-lester:client:Explosive',
                    type = 'client',
                    icon = "fas fa-laptop",
                    label = "Do it",
                },
            },
            distance = Config.Distance,
        })
    end)
end
if isCooldown == false then
    return false
end
end)

RegisterNetEvent('cosmos-lester:client:Explosive')
AddEventHandler('cosmos-lester:client:Explosive', function()
    if disableHacking == true then
        hasThermite = false
        print("Now on Cooldown")
        QBCore.Functions.Notify("System on cooldown for "..math.floor(Config.CoolDown).. " minutes please come back later")
        Citizen.Wait(Config.Cooling)
        disableHacking = false
    end
    if isCooldown == true then
    local ped = PlayerPedId()
    local dict = "anim@mp_player_intmenu@key_fob@"
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasThermite)
        if hasThermite == true then
            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
            exports['hacking']:OpenHackingGame(20, 5, 5, function(Success)
                print(Success)
                if Success then
                    SetEntityCoords(ped, vehcoords, false)
                    gotLoot()
                    disableHacking = true
                else
                    QBCore.Functions.Notify("You failed!", "error")
                    disableHacking = true
                    exports['ps-dispatch']:LesterHeist()
                    copsCalled = true
                end
        end)
    else
        QBCore.Functions.Notify("You are missing something", "error")
        end
    end, "thermite")
end
if isCooldown == false then
    QBCore.Functions.Notify("Need to do something before this!", "error")
end
end)

RegisterCommand('setlesterstate', function(source, args)
    TriggerEvent('chat:addSuggestion', "True or False")
    local answer = args[1]
if answer == "true" then
    isCooldown = true
    QBCore.Functions.Notify("Lester Robbery has been set to true")
    print("Lester Robbery Staus: True")
end
if answer == "false" then
    isCooldown = false
    QBCore.Functions.Notify("Lester Robbery has been set to false")
    print("Lester Robbery Staus: False")
end
if answer == nil then
    QBCore.Functions.Notify('Arguments must be filled out', 'error')
end
end, false)

RegisterCommand('resetlesterbank', function(source, args)
    isCooldown = false
    disableHacking = false
    QBCore.Functions.Notify("Robbery has been rest")
end)

function gotLoot()
    local pcoords = GetEntityCoords(PlayerPedId())
    local distance = (#pcoords - #vehcoords)
    if distance <= 5.0 then
        exports['ps-dispatch']:NearTruck()
    end
end
