-----------------------------------
-- Assault: Imperial Agent Rescue
-- An agent sent to spy on the secret training grounds of the Mamool Ja has been captured. Rescue him before he is interrogated for Imperial secrets.
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
require("scripts/globals/zone")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assaultUtil.mission.IMPERIAL_AGENT_RESCUE and
           player:getCharVar("assaultEntered") == 0 and
           player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
           player:getMainLvl() > 50
end

instance_object.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
           player:getCurrentAssault() == xi.assaultUtil.mission.IMPERIAL_AGENT_RESCUE and
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

    player:setCharVar("assaultEntered", 1)
    xi.assaultUtil.afterInstanceRegister(player, xi.items.CAGE_OF_BHAFLAU_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(220.000, 1.465, -504.999, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(220.000, 1.619, -502.999, 0)
    instance:setProgress(math.random(ID.npc.POT_HATCH, ID.npc.POT_HATCH + 2))
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    xi.assaultUtil.onInstanceFailure(instance)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
end

instance_object.onInstanceComplete = function(instance)
    xi.assaultUtil.onInstanceComplete(instance, 9, 8)
end

instance_object.onEventFinish = function(player, csid, option)
    xi.assaultUtil.instanceOnEventFinish(player, csid, xi.zone.BHAFLAU_THICKETS)
end

return instance_object
