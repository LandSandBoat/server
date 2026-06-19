-----------------------------------
-- Assault: Lebros Supplies
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.LEBROS_SUPPLIES and
        player:getCharVar('assaultEntered') == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 50
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.LEBROS_SUPPLIES and
        player:getCharVar('assaultEntered') == 0 and
        player:getMainLvl() > 50
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    xi.assault.afterInstanceRegister(player, xi.item.CAGE_OF_ZHAYOLM_FIREFLIES)

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-330, -10, -262, 128)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-330, -10, -265, 128)
end

instanceObject.onInstanceCreated = function(instance)
    for i, stormerID in pairs(ID.npc.IMPERIAL_STORMER) do
        local npc = GetNPCByID(stormerID, instance)

        if npc then
            npc:setStatus(xi.status.NORMAL)
            npc:setLocalVar('Hunger', math.random(6, 7))
        end
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 12 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8)
end

instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

return instanceObject
