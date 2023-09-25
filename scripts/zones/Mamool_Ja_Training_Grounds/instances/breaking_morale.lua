-----------------------------------
-- Assault: Breaking Morale
-- Instance: 6603
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.BREAKING_MORALE and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 60
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.MAMOOL_JA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.BREAKING_MORALE and
        player:getCharVar("assaultEntered") == 0 and
        player:getMainLvl() > 60
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
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(18, 2, 136, 65)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(20, 2, 136, 65)
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
    xi.assault.onInstanceComplete(instance, 7, 6) -- (H-6)
end

instanceObject.onEventFinish = function(player, csid, option)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.BHAFLAU_THICKETS)
end

return instanceObject
