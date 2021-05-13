-----------------------------------
-- Assault: Orichalcum Survey
-- General Afkaam is to inspect Leujaoam Sanctum.
-- Destroy all creatures in the area that may pose a threat to the general.
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/instance")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/assault")
require("scripts/globals/zone")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    assaultUtil.afterInstanceRegister(player, 5343, ID.text, ID.mob) -- Azouph Fireflies
end

instance_object.onInstanceCreated = function(instance)
    local miningPoints = utils.shuffle(ID.mob[ORICHALCUM_SURVEY].MINING_POINTS)
    local points = 5
    while points > 0 do
        for _, point in pairs(miningPoints) do
            if instance:getEntity(bit.band(point, 0xFFF), xi.objType.NPC):getStatus() == xi.status.DISAPPEAR then
                instance:getEntity(bit.band(point, 0xFFF), xi.objType.NPC):setStatus(xi.status.NORMAL)
                instance:getEntity(bit.band(point, 0xFFF), xi.objType.NPC):setLocalVar("Mined", math.random(5, 10))
            end
            points = points - 1
        end
    end

    instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), xi.objType.NPC):setPos(-432.000, -27.627, 169.000, 129)
    instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), xi.objType.NPC):setPos(-432.000, -27.588, 167.000, 129)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    assaultUtil.onInstanceFailure(instance, 102, ID.text)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 1 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    assaultUtil.onInstanceComplete(player, instance, 7, 8, ID.text, ID.npc)
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    assaultUtil.instanceOnEventFinish(player, csid, 102, xi.zone.CAEDARVA_MIRE)
end

return instance_object
