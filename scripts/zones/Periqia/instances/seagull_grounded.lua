-----------------------------------
-- Assault: Seagull Grounded
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
require("scripts/globals/zone")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assaultUtil.mission.SEAGULL_GROUNDED and
           player:getCharVar("assaultEntered") == 0 and
           player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
           player:getMainLvl() > 50
end

instance_object.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assaultUtil.mission.SEAGULL_GROUNDED and
           player:getCharVar("assaultEntered") == 0 and
           player:getMainLvl() > 50
end

instance_object.onInstanceCreated = function(instance)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.assaultUtil.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assaultUtil.afterInstanceRegister(player, xi.items.CAGE_OF_REEF_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-495.000,-9.695,-72.000,0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-490.000,-9.900,-72.000,0)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    local mob = GetMobByID(ID.mob[xi.assaultUtil.mission.SEAGULL_GROUNDED].MOBS_START.EXCALIAC, instance)
    if mob ~= nil then
        onTrack(mob)
    end
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    xi.assaultUtil.onInstanceFailure(instance)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
end

instance_object.onInstanceComplete = function(instance)
    xi.assaultUtil.onInstanceComplete(instance, 8, 8)
end

instance_object.onEventFinish = function(player, csid, option)
    xi.assaultUtil.instanceOnEventFinish(player, csid, xi.zone.BHAFLAU_THICKETS)
end

return instance_object
