local QBCore = exports['qb-core']:GetCoreObject();
local onCoolDown = false
local status = false
local inProgress = false
local onCoolDown = isCooldown

RegisterNetEvent('cosmos-lester:sever:PlayerCooldown')
AddEventHandler('cosmos-lester:sever:PlayerCooldown', function()
    if onCoolDown == true then
        QBCore.Functions.Notify("Someone Already Hit the system", "error")
    end
    if onCoolDown == false then
        return false
    end
end)
