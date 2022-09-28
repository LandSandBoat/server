-----------------------------------
-- Assault: Excavation Duty
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assault.mission.EXCAVATION_DUTY and
           player:getCharVar("assaultEntered") == 0 and
           player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
           player:getMainLvl() > 50
end

instance_object.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEBROS_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assault.mission.EXCAVATION_DUTY and
           player:getCharVar("assaultEntered") == 0 and
           player:getMainLvl() > 50
end

instance_object.onInstanceCreated = function(instance)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_ZHAYOLM_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(49.999, -40.837, 96.999, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(50.000, -40.070, 99.999, 0)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 5 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 5, 10)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
