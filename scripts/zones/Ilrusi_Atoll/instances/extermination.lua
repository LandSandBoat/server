  
-----------------------------------
--
-- Assault: Extermination
--
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/assault")
require("scripts/globals/zone")
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    assaultUtil.afterInstanceRegister(player, 5347, ID.text, ID.mob)
end

instance_object.onInstanceCreated = function(instance)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(290.857,-3.424,132.339,148)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(293.637,-3.376,130.364,148)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, Ilrusi.text)
end

instance_object.onInstanceFailure = function(instance)
    assaultUtil.onInstanceFailure(instance, 102, ID.text)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress == 20 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    assaultUtil.onInstanceComplete(player, instance, 8, 8, ID.text, ID.npc) -- TODO: verify
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    assaultUtil.instanceOnEventFinish(player, 102, xi.zone.ARRAPAGO_REEF)
end

return instance_object
