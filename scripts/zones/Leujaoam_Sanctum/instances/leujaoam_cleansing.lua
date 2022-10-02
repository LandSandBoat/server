-----------------------------------
-- Assault: Leujaoam Cleansing
-- instance 6900
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assault.mission.LEUJAOAM_CLEANSING and
           player:getCharVar("assaultEntered") == 0 and
           player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
           player:getMainLvl() > 50
end

instance_object.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assault.mission.LEUJAOAM_CLEANSING and
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

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_AZOUPH_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(476.000, 8.479, 40.000, 49)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(476.000, 8.479, 39.000, 49)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 1 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
