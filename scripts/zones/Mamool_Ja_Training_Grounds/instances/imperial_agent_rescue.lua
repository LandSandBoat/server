-----------------------------------
-- Assault: Imperial Agent Rescue
-- An agent sent to spy on the secret training grounds of the Mamool Ja has been captured. Rescue him before he is interrogated for Imperial secrets.
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.IMPERIAL_AGENT_RESCUE and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 50
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.IMPERIAL_AGENT_RESCUE and
        player:getCharVar("assaultEntered") == 0 and
        player:getMainLvl() > 50
end

instanceObject.onInstanceCreated = function(instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_BHAFLAU_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(220.000, 1.465, -504.999, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(220.000, 1.619, -502.999, 0)
    instance:setProgress(math.random(ID.npc.POT_HATCH, ID.npc.POT_HATCH + 2))
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
    xi.assault.onInstanceComplete(instance, 9, 8)
end

instanceObject.onEventFinish = function(player, csid, option)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.BHAFLAU_THICKETS)
end

return instanceObject
