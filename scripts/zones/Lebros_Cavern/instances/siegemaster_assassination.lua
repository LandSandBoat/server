-----------------------------------
-- Assault: Siegemaster Assassination
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SIEGEMASTER_ASSASSINATION and
        player:getCharVar('assaultEntered') == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 50
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SIEGEMASTER_ASSASSINATION and
        player:getCharVar('assaultEntered') == 0 and
        player:getMainLvl() > 50
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.item.CAGE_OF_ZHAYOLM_FIREFLIES)

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-1.000, -49.999, -320.999, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-1.000, -49.999, -318.999, 0)
end

instanceObject.onInstanceCreated = function(instance)
    local totalTrolls = 8
    local borgerlur = math.random(totalTrolls)
    instance:setProgress(borgerlur)
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
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 7, 7)
end

instanceObject.onEventUpdate = function(player, csid, option, npc)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

return instanceObject
