-- Variables
Config = Config or {}


local CurrentStatusList = {}
local Evidences = {
    Casings = {},
    Blooddrops = {},
    Fingerprints = {}
}
local CurrentEvidences = nil
local shotAmount = 0

local StatusList = {
    ["fight"] = Lang:t("evidence.red_hands"),
    ["widepupils"] = Lang:t("evidence.wide_pupils"),
    ["redeyes"] = Lang:t("evidence.red_eyes"),
    ["weedsmell"] = Lang:t("evidence.weed_smell"),
    ["gunpowder"] = Lang:t("evidence.gunpowder"),
    ["chemicals"] = Lang:t("evidence.chemicals"),
    ["heavybreath"] = Lang:t("evidence.heavy_breathing"),
    ["sweat"] = Lang:t("evidence.sweat"),
    ["handbleed"] = Lang:t("evidence.handbleed"),
    ["confused"] = Lang:t("evidence.confused"),
    ["alcohol"] = Lang:t("evidence.alcohol"),
    ["heavyalcohol"] = Lang:t("evidence.heavy_alcohol"),
    ["agitated"] = Lang:t("evidence.agitated")
}

local WhitelistedWeapons = {
    0xC715F939,
    0x126210c3,
    0xA00FC1E4,
    0xb5fd67cd,
    0x60b51da4,
    0x126210c3,
}


function VarString(txt)
    
    return 
end

function BgDisplayText(txt, x, y)
    return Citizen.InvokeNative(0xd79334a4bb99bad1, Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong()), x, y)
end
-- Functions
local function DrawText3D(x, y, z, text)
    coords = vector3(x, y, z)
    local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextColor(255, 255, 255, 215)
        --SetTextFontForCurrentCommand(4)
        SetTextDropshadow(0, 0, 0, 255)
        --SetTextCentre(true)
        
        BgDisplayText(text, x * 1.0, y * 1.0)
    end
end

local function WhitelistedWeapon(weapon)
    local weaponGroup = GetWeapontypeGroup(weapon)
    for i=1, #WhitelistedWeapons do
        if WhitelistedWeapons[i] == weaponGroup then
            return true
        end
    end
    return false
end

local function DropBulletCasing(weapon, ped)
    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
    local coords2 = vector3(coords.x, coords.y, coords.z - 0.9)
    TriggerServerEvent("evidence:server:CreateCasing", weapon, coords)
    Wait(300)
end

-- Events
RegisterNetEvent("evidence:client:SetStatus", function(statusId, time)
    if time > 0 and StatusList[statusId] then
        if (CurrentStatusList == nil or CurrentStatusList[statusId] == nil) or
            (CurrentStatusList[statusId] and CurrentStatusList[statusId].time < 20) then
            CurrentStatusList[statusId] = {
                text = StatusList[statusId],
                time = time
            }
            exports["qbr-core"]:Notify(9, CurrentStatusList[statusId].text, 5000, 0, "mp_lobby_textures", "cross", "COLOR_WHITE")
        end
    elseif StatusList[statusId] then
        CurrentStatusList[statusId] = nil
    end
    TriggerServerEvent("evidence:server:UpdateStatus", CurrentStatusList)
end)

RegisterNetEvent("evidence:client:AddEvidence", function(data)
    assert(data, "[Client] [QBR-PoliceJob-evidence:client:AddEvidence] Missing data")
    assert(data.coords, "[Client] [QBR-PoliceJob-evidence:client:AddEvidence] Missing coords")
    local categoryId = data.categoryId 
    assert(categoryId, "[Client] [QBR-PoliceJob-evidence:client:AddEvidence] Missing categoryId")
    local id = data.id
    assert(id, "[Client] [QBR-PoliceJob-evidence:client:AddEvidence] Missing id")

    if not Evidences[categoryId] then Evidences[categoryId] = {} end
    Evidences[categoryId][id] = data
end)

RegisterNetEvent("evidence:client:RemoveEvidence", function(evidenceCategory, evidenceId )
    if Evidences[evidenceCategory] then 
        Evidences[evidenceCategory][evidenceId] = nil
    end
    
    if CurrentEvidences[evidenceCategory] then 
        CurrentEvidences[evidenceCategory][evidenceId] = nil
    end    
end)

RegisterNetEvent("evidence:client:ClearBlooddropsInArea", function()
    local pos = GetEntityCoords(PlayerPedId())
    local blooddropList = {}
    exports["qbr-core"]:Progressbar("clear_blooddrops", Lang:t("progressbar.blood_clear"), 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        if Evidences.Blooddrops and next(Evidences.Blooddrops) then
            for bloodId, v in pairs(Evidences.Blooddrops) do
                if #(pos - vector3(Evidences.Blooddrops[bloodId].coords.x, Evidences.Blooddrops[bloodId].coords.y, Evidences.Blooddrops[bloodId].coords.z)) < 10.0 then
                    blooddropList[#blooddropList+1] = bloodId
                end
            end
            TriggerServerEvent("evidence:server:ClearBlooddrops", blooddropList)
            exports["qbr-core"]:Notify(9, Lang:t("success.blood_clear"), 5000, 0, "hud_textures", "check", "COLOR_WHITE")
        end
    end, function() -- Cancel
        exports["qbr-core"]:Notify(9, Lang:t("error.blood_not_cleared"), 5000, 0, "mp_lobby_textures", "cross", "COLOR_WHITE")
    end)
end)

RegisterNetEvent("evidence:client:ClearCasingsInArea", function()
    local pos = GetEntityCoords(PlayerPedId())
    local casingList = {}
    exports["qbr-core"]:Progressbar("clear_casings", Lang:t("progressbar.bullet_casing"), 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        if Evidences.Casings and next(Evidences.Casings) then
            for casingId, v in pairs(Evidences.Casings) do
                if #(pos - vector3(Evidences.Casings[casingId].coords.x, Evidences.Casings[casingId].coords.y, Evidences.Casings[casingId].coords.z)) <
                    10.0 then
                    casingList[#casingList+1] = casingId
                end
            end
            TriggerServerEvent("evidence:server:ClearCasings", casingList)
            exports["qbr-core"]:Notify(9, Lang:t("success.bullet_casing_removed"), 5000, 0, "hud_textures", "check", "COLOR_WHITE")

        end
    end, function() -- Cancel
        exports["qbr-core"]:Notify(9, Lang:t("error.bullet_casing_not_removed"), 5000, 0, "mp_lobby_textures", "cross", "COLOR_WHITE")
    end)
end)

-- Threads
local isPickingUp = false
local isChecking = false
local shouldRunEvidences = false
local shouldRunStatus = false

function NextToEvidence(evidence, categoryId, id)
    if not evidence then return end 
    local pos = GetEntityCoords(PlayerPedId())
    local coords = vector3(evidence.coords.x, evidence.coords.y, evidence.coords.z)
    if #(pos - coords ) > Config.EvidenceRange then return end

    local drawtext = evidence.drawtext
    if not drawtext then return end
    DrawText3D(coords.x, coords.y, coords.z, drawtext)

    if not IsControlJustReleased(0, 0x5415BE48) then return end
    if isPickingUp then return end
    isPickingUp = true
    TriggerServerEvent("evidence:server:AddEvidenceToInventory", categoryId, id, evidence)
    CreateThread(function()
        Wait(1000)
        isPickingUp = false
    end)
end

function DistanceCheckForEvidence()
    CreateThread(function()
        while isChecking do
            Wait(1)
            for categoryId, evidences in pairs(CurrentEvidences or {}) do               
                for id, evidence in pairs(evidences) do 
                    NextToEvidence(evidence, categoryId, id)
                end                
            end
        end
    end)
end

function GetPedCurrentHeldWeapon(ped)
    return Citizen.InvokeNative(0x8425C5F057012DAB, ped)
end

function UpdateCurrentEvidences()
    for index, evidence in pairs(Evidences) do
        if next(evidence) then
            local pos = GetEntityCoords(PlayerPedId(), true)
            for id, data in pairs(evidence) do
                local dist = #(pos - vector3(data.coords.x, data.coords.y, data.coords.z))
                if dist < Config.EvidenceRange then
                    if not CurrentEvidences then 
                        CurrentEvidences = {}
                    end
                    if not CurrentEvidences[index] then
                        CurrentEvidences[index] = {}
                    end                    
                    CurrentEvidences[index][id] = data   
                elseif CurrentEvidences and CurrentEvidences[index] and CurrentEvidences[index][id] then
                    CurrentEvidences[index][id] = nil                               
                end
            end
        end
    end
end

function SetupEvidencesLoops()
    --Loop for checking closest evidence for types.
    CreateThread(function()
        while shouldRunEvidences do 
            Wait(10)
            if GetPedCurrentHeldWeapon(PlayerPedId()) == `WEAPON_MELEE_LANTERN` then
                UpdateCurrentEvidences()
                if not isChecking then 
                    isChecking = true
                    DistanceCheckForEvidence()
                end                
            elseif isChecking then
                isChecking = false
            end
        end
    end)
end

function StartStatusLoop()
    CreateThread(function() -- Player Status Thread
        while shouldRunStatus do
            Wait(10000)
            if LocalPlayer.state.isLoggedIn then
                if CurrentStatusList and next(CurrentStatusList) then
                    for k, v in pairs(CurrentStatusList) do
                        if CurrentStatusList[k].time > 0 then
                            CurrentStatusList[k].time = CurrentStatusList[k].time - 10
                        else
                            CurrentStatusList[k].time = 0
                        end
                    end
                    TriggerServerEvent("evidence:server:UpdateStatus", CurrentStatusList)
                end
                if shotAmount > 0 then
                    shotAmount = 0
                end
            end
        end
    end)
end


function StartGunpowderLoop()
    CreateThread(function() -- Gunpowder Status when shooting
        while shouldRunStatus do
            Wait(1)
            local ped = PlayerPedId()
           
            if IsPedShooting(ped) then
                local weapon = GetPedCurrentHeldWeapon(ped)
                if not WhitelistedWeapon(weapon) then
                    shotAmount = shotAmount + 1
                    if shotAmount > 5 and (CurrentStatusList == nil or CurrentStatusList["gunpowder"] == nil) then
                        if math.random(1, 10) <= 7 then
                            TriggerEvent("evidence:client:SetStatus", "gunpowder", 200)
                        end
                    end
                    DropBulletCasing(weapon, ped)
                end
            end
        end
    end)
end

RegisterNetEvent("QBCore:Client:OnPlayerUnloaded", function()
    shouldRunStatus = false
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(playerData)
    PlayerJob = playerData.job
    local name = PlayerJob.name
    local onduty = PlayerJob.onduty
    
    if not shouldRunStatus then
        shouldRunStatus = true
        StartGunpowderLoop()
        StartStatusLoop()
    end

    if Config.EvidenceJobs[name] and onduty then
        if shouldRunEvidences then return end
        shouldRunEvidences = true
        SetupEvidencesLoops() -- Check if 
    else
        shouldRunEvidences = false
    end
end)

-- RegisterCommand("ammo", function(source, args, rawCommand)
--     local ped = PlayerPedId()

--     local _, weapon = GetCurrentPedWeapon(ped)
--     print(source,ped, weapon)
--     SetPedInfiniteAmmo(ped, true, weapon)
-- end, false)
