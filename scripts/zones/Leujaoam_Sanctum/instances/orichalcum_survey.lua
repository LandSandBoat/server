-----------------------------------
-- Assault: Orichalcum Survey
-- instance 6901
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/assault")
require("scripts/globals/instance")
require("scripts/globals/items")
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.ORICHALCUM_SURVEY and
        player:getCharVar("assaultEntered") == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 50
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.ORICHALCUM_SURVEY and
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

    xi.assault.afterInstanceRegister(player, xi.items.CAGE_OF_AZOUPH_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-432.000, -27.627, 169.000, 129)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-432.000, -27.588, 167.000, 129)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 2 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8) -- (H-8)
end

instanceObject.onEventFinish = function(player, csid, option)
    xi.assault.instanceOnEventFinish(player, csid, xi.zone.CAEDARVA_MIRE)
end

return instanceObject
