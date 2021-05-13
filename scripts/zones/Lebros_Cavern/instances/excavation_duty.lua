-----------------------------------
-- Assault: Excavation Duty
-- The Imperial Army plans to traverse Lebros Cavern as part of their attack on Halvung,
-- however the tunnels are blocked with rocks. You must remove the obstructions.
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/missions")
require("scripts/globals/assault")
require("scripts/globals/zone")
local ID = require("scripts/zones/Lebros_Cavern/IDs")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    assaultUtil.afterInstanceRegister(player, 5345, ID.text, ID.mob)
end

instance_object.onInstanceCreated = function(instance)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(49.999,-40.837,96.999,0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(50.000,-40.070,99.999,0)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    assaultUtil.onInstanceFailure(instance, 102, ID.text)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 5 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    assaultUtil.onInstanceComplete(player, instance, 5, 10, ID.text, ID.npc)
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    assaultUtil.instanceOnEventFinish(player, 102, xi.zone.MOUNT_ZHAYOLM)
end

return instance_object
