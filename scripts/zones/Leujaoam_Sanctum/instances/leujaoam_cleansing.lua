-----------------------------------
-- Assault: Leujaoam Cleansing
-- General Afkaam is to inspect Leujaoam Sanctum.
-- Destroy all creatures in the area that may pose a threat to the general.
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/instance")
require("scripts/globals/missions")
require("scripts/globals/assault")
require("scripts/globals/zone")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    assaultUtil.afterInstanceRegister(player, 5343, ID.text, ID.mob) -- Azouph Fireflies
end

instance_object.onInstanceCreated = function(instance)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(476.000, 8.479, 40.000, 49)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(476.000, 8.479, 39.000, 49)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    assaultUtil.onInstanceFailure(instance, 102, ID.text)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 15 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    assaultUtil.onInstanceComplete(player, instance, 8, 8, ID.text, ID.npc)
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    assaultUtil.instanceOnEventFinish(player, 102, xi.zone.CAEDARVA_MIRE)
end

return instance_object
