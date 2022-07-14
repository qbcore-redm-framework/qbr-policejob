-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil
promptsStatus = false
-- Functions
-- local function DrawText3D(x, y, z, text)
--     SetTextScale(0.35, 0.35)
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextColour(255, 255, 255, 215)
--     SetTextEntry("STRING")
--     SetTextCentre(true)
--     AddTextComponentString(text)
--     SetDrawOrigin(x,y,z, 0)
--     DrawText(0.0, 0.0)
--     local factor = (string.len(text)) / 370
--     DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
--     ClearDrawOrigin()
-- end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    exports['qbr-core']:SpawnVehicle(vehicleInfo, function(veh)
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
	Citizen.InvokeNative(0x400F9556,veh, Lang:t('info.police_plate')..tostring(math.random(1000, 9999)))
        -- if Config.VehicleSettings[vehicleInfo] ~= nil then
        --     QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
        -- end
        --TriggerEvent("vehiclekeys:client:SetOwner", exports['qbr-core']:GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = Lang:t('menu.garage_title'),
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[exports['qbr-core']:GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t('menu.close'),
        txt = "",
        params = {
            event = "qbr-menu:client:closeMenu"
        }

    }
    exports['qbr-menu']:openMenu(vehicleMenu)
end

function CreatePrompts()
    for k,v in pairs(Config.Locations['duty']) do
        exports['qbr-core']:createPrompt('duty_prompt_' .. k, v, Config.PromptKey, 'Toggle duty status', {
            type = 'client',
            event = 'police:client:promptDuty',
            args = {},
        })
    end

    for k, v in pairs(Config.Locations["vehicle"]) do
        exports['qbr-core']:createPrompt("police:vehicle_"..k, vector3(v.x, v.y, v.z), Config.PromptKey, Lang:t('menu.pol_garage'), {
            type = 'client',
            event = 'police:client:promptVehicle',
            args = {k},
        })
    end

    for k,v in pairs(Config.Locations['evidence']) do
        exports['qbr-core']:createPrompt('evidence_prompt_' .. k, v, Config.PromptKey, 'Open Evidence Stash', {
            type = 'client',
            event = 'police:client:EvidenceStashDrawer',
            args = { k },
        })
    end

    for k,v in pairs(Config.Locations['stash']) do
        exports['qbr-core']:createPrompt('stash_prompt_' .. k, v, Config.PromptKey, 'Open Personal Stash', {
            type = 'client',
            event = 'police:client:OpenPersonalStash',
            args = {},
        })
    end

    for k,v in pairs(Config.Locations['armory']) do
        exports['qbr-core']:createPrompt('armory_prompt_' .. k, v, Config.PromptKey, Lang:t('menu.pol_armory'), {
            type = 'client',
            event = 'police:client:OpenArmory',
            args = {},
        })
    end
    promptsStatus = true
end

function DeletePrompts()
    for k,v in pairs(Config.Locations['duty']) do
        exports['qbr-core']:deletePrompt('duty_prompt_' .. k, v, Config.PromptKey, 'Toggle duty status', {
            type = 'client',
            event = 'police:client:promptDuty',
            args = {},
        })
    end

    for k, v in pairs(Config.Locations["vehicle"]) do
        exports['qbr-core']:deletePrompt("police:vehicle_"..k, vector3(v.x, v.y, v.z), Config.PromptKey, Lang:t('menu.pol_garage'), {
            type = 'client',
            event = 'police:client:promptVehicle',
            args = {k},
        })
    end

    for k,v in pairs(Config.Locations['evidence']) do
        exports['qbr-core']:deletePrompt('evidence_prompt_' .. k, v, Config.PromptKey, 'Open Evidence Stash', {
            type = 'client',
            event = 'police:client:EvidenceStashDrawer',
            args = { k },
        })
    end

    for k,v in pairs(Config.Locations['stash']) do
        exports['qbr-core']:deletePrompt('stash_prompt_' .. k, v, Config.PromptKey, 'Open Personal Stash', {
            type = 'client',
            event = 'police:client:OpenPersonalStash',
            args = {},
        })
    end

    for k,v in pairs(Config.Locations['armory']) do
        exports['qbr-core']:deletePrompt('armory_prompt_' .. k, v, Config.PromptKey, Lang:t('menu.pol_armory'), {
            type = 'client',
            event = 'police:client:OpenArmory',
            args = {},
        })
    end
    promptsStatus = false
end




local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = exports['qbr-core']:GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if exports['qbr-core']:GetPlayerData().job.name == 'police' then
        retval = true
    end
    return retval
end

local function SetWeaponSeries()
    for k, v in pairs(Config.Items.items) do
        if k < 6 then
            Config.Items.items[k].info.serie = tostring(exports['qbr-core']:RandomInt(2) .. exports['qbr-core']:RandomStr(3) .. exports['qbr-core']:RandomInt(1) .. exports['qbr-core']:RandomStr(2) .. exports['qbr-core']:RandomInt(3) .. exports['qbr-core']:RandomStr(4))
        end
    end
end

RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = exports['qbr-core']:GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['LegacyFuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            local plate = exports['qbr-core']:GetPlate(vehicle)
            TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)
            exports['qbr-core']:DeleteVehicle(vehicle)
        end
    end
end)

-- Toggle Duty in an event.
RegisterNetEvent('police:client:promptDuty', function()
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        if PlayerJob.name == "police" then
            onDuty = not onDuty
            TriggerServerEvent("police:server:UpdateCurrentCops")
            TriggerServerEvent("police:server:UpdateBlips")
            TriggerServerEvent("QBCore:ToggleDuty")
        else
            exports['qbr-core']:Notify(9, Lang:t('error.not_lawyer'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end)
end)

RegisterNetEvent('police:client:promptVehicle', function(k)
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        local ped = PlayerPedId()

        if PlayerJob.name == "police"  then
            if IsPedInAnyVehicle(ped, false) then
                exports['qbr-core']:DeleteVehicle(GetVehiclePedIsIn(ped))
            else
                MenuGarage()
                currentGarage = k
            end
        else
            exports['qbr-core']:Notify(9, Lang:t('error.not_lawyer'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end)
end)



RegisterNetEvent('police:client:CheckStatus', function()
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                exports['qbr-core']:TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for k, v in pairs(result) do
                            exports['qbr-core']:Notify(9, ''..v..'')
                        end
                    end
                end, playerId)
            else
                exports['qbr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        end
    end)
end)

RegisterNetEvent('police:client:EvidenceStashDrawer', function(k)
    local currentEvidence = k
    local pos = GetEntityCoords(PlayerPedId())
    local takeLoc = Config.Locations["evidence"][currentEvidence]

    if not takeLoc then return end

    if #(pos - takeLoc) <= 1.0 then
        local drawer = LocalInput(Lang:t('info.slot'), 11)
        if tonumber(drawer) then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer}), {
                maxweight = 4000000,
                slots = 500,
            })
            TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawer}))
        end
    end
end)

RegisterNetEvent('police:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('police:client:OpenPersonalStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..exports['qbr-core']:GetPlayerData().citizenid)
    TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..exports['qbr-core']:GetPlayerData().citizenid)
end)

RegisterNetEvent('police:client:OpenPersonalTrash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
        maxweight = 4000000,
        slots = 300,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
end)

RegisterNetEvent('police:client:OpenArmory', function()
    local authorizedItems = {
        label = Lang:t('menu.pol_armory'),
        slots = 30,
        items = {}
    }
    -- local index = 1
    for index, armoryItem in pairs(Config.Items.items) do
        for i=1, #armoryItem.authorizedJobGrades do
            if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                -- index = index + 1
            end
        end
    end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
end)



-- Threads

-- Toggle Duty
CreateThread(function()
    if LocalPlayer.state.isLoggedIn and PlayerJob.name == 'police' then
        CreatePrompts()
    end

    for k, v in pairs(Config.Locations["stations"]) do
        --print(v.coords, v.label)
        local StationBlip = N_0x554d9d53f696d002(1664425300, v.coords)
        SetBlipSprite(StationBlip, -693644997, 52)
        SetBlipScale(StationBlip, 0.7)
        Citizen.InvokeNative(0x9CB1A1623062F402, StationBlip, v.label)
        -- Citizen.ReturnResultAnyway()
    end
    local sharedItems = exports['qbr-core']:GetItems()
    local sharedWeapons = exports['qbr-core']:GetWeapons()
    for k,v in pairs(sharedWeapons) do
        local weaponName = v.name
        local weaponLabel = v.label
        local weaponHash = GetHashKey(v.name)
        local weaponAmmo, weaponAmmoLabel = nil, 'unknown'
        if v.ammotype then
            weaponAmmo = v.ammotype:lower()
            weaponAmmoLabel = sharedItems[weaponAmmo].label
        end

        --print(weaponHash, weaponName, weaponLabel, weaponAmmo, weaponAmmoLabel)

        Config.WeaponHashes[weaponHash] = {
            weaponName = weaponName,
            weaponLabel = weaponLabel,
            weaponAmmo = weaponAmmo,
            weaponAmmoLabel = weaponAmmoLabel
        }
    end
end)


