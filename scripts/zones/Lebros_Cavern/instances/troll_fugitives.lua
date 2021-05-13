-----------------------------------
--
-- Assault: Troll Fugitives
--
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
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-376.272,-9.893,89.189,0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-384.097,-10,84.954,49)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, Lebros.text)
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
    assaultUtil.onInstanceComplete(player, instance, 7, 9, ID.text, ID.npc)
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    assaultUtil.instanceOnEventFinish(player, 102, xi.zone.MOUNT_ZHAYOLM)
end

return instance_object
