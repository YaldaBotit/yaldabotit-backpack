QBCore = exports[config.FrameworkResource]:GetCoreObject()


local function GenderCheck()
    local PlayerPed = PlayerPedId()
    if IsPedModel(PlayerPed,"mp_m_freemode_01") then
        gender = 'male'
    elseif IsPedModel(PlayerPed,"mp_f_freemode_01") then
        gender = 'female'
    else
        gender = 'custom'
    end
    return(gender)
end

local function ItemCheck()
    local PlayerPed = PlayerPedId()
    local PlayerGender = GenderCheck()
    for i = 1,#config.Bags,1 do
        if QBCore.Functions.HasItem(config.Bags[i].Item) then
            CurrentBag = i
            break
        else
            CurrentBag = nil
        end
    end
    if CurrentBag ~= nil then
        if PlayerGender == 'male' then
            SetPedComponentVariation(PlayerPed, 5, config.Bags[CurrentBag].ClothingMaleID, config.Bags[CurrentBag].MaleTextureID, 0)
        elseif PlayerGender == 'female' then
            SetPedComponentVariation(PlayerPed, 5, config.Bags[CurrentBag].ClothingFemaleID, config.Bags[CurrentBag].FemaleTextureID, 0)
        end
    else
        SetPedComponentVariation(PlayerPed, 5, 0, 0, 0)
    end
end

if config.InvType == 'qb' then
    RegisterNetEvent('yaldabotit-backpack:client:OpenBag', function(ItemID,ItemInfo)
        TriggerEvent("inventory:client:SetCurrentStash", 'Backpack'..tostring(ItemID))
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'Backpack'..tostring(ItemID), {maxweight = config.Bags[ItemInfo].InsideWeight , slots = config.Bags[ItemInfo].Slots})
    end)
elseif config.InvType == 'ox' then
    RegisterNetEvent('yaldabotit-backpack:client:OpenBag', function(ItemID,ItemInfo)
        Wait(1000)
        exports[config.InvName]:openInventory('stash', 'Backpack'..tostring(ItemID))
    end)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1000)
    ItemCheck()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Wait(1000)
    ItemCheck()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function()
    Wait(1000)
    ItemCheck()
end)

AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() == resource then
        Wait(1000)
        ItemCheck()
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        Wait(1000)
        ItemCheck()
	end
end)