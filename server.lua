QBCore = exports[config.FrameworkResource]:GetCoreObject()

local loadFile = LoadResourceFile(GetCurrentResourceName(), "./IdList.json")
local IdList = json.decode(loadFile)

local function GenerateID(id)
    local id = math.random(1000000000,9999999999)
    for i = 1,#IdList,1 do
        while IdList[i] == id do
            id = math.random(1000000000,9999999999)
        end
    end
    IdList[#IdList+1] = id
    SaveResourceFile(GetCurrentResourceName(), "IdList.json", json.encode(IdList), 0)
    return(id)
end

if config.InvType == 'qb' then
    for i = 1,#config.Bags,1 do
        QBCore.Functions.CreateUseableItem(config.Bags[i].Item, function(source,item)
            if not item.info.id then
                local Player = QBCore.Functions.GetPlayer(source)
                local newitem = Player.PlayerData.items[item.slot]
                newitem.info.id = GenerateID() 
                exports[config.InvName]:SetInventory(source,Player.PlayerData.items)
                TriggerClientEvent('yaldabotit-backpack:client:OpenBag',source,newitem.info.id,i)
            else
            TriggerClientEvent('yaldabotit-backpack:client:OpenBag',source,item.info.id,i)
            end
        end)
    end
elseif config.InvType == 'ox' then
    for i = 1,#config.Bags,1 do
        QBCore.Functions.CreateUseableItem(config.Bags[i].Item, function(source,item)
            if not item.metadata.id then
                item.metadata.id = GenerateID() 
                exports[config.InvName]:SetMetadata(source, item.slot, item.metadata)
            end
            exports[config.InvName]:RegisterStash('Backpack'..tostring(item.metadata.id),'Backpack', config.Bags[i].Slots, config.Bags[i].InsideWeight)
            TriggerClientEvent('yaldabotit-backpack:client:OpenBag',source,item.metadata.id,i)
        end)
    end
end