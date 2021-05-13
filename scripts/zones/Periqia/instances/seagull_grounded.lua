-----------------------------------
-- Assault: Seagull Grounded
-- The Immortals have captured a member of the Seagull Phratrie, a rebel organization.
-- You are to escort the prisoner safely to a holding area.
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/instance")
require("scripts/globals/missions")
require("scripts/globals/assault")
require("scripts/globals/zone")
require("scripts/zones/Periqia/mobs/Excaliace")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    assaultUtil.afterInstanceRegister(player, 5346, ID.text, ID.mob)
end

instance_object.onInstanceCreated = function(instance)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-495.000,-9.695,-72.000,0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-490.000,-9.900,-72.000,0)

    GetNPCByID(ID.npc._1K6, instance):setAnimation(8)
    GetNPCByID(ID.npc._1KX, instance):setAnimation(8)
    GetNPCByID(ID.npc._1KZ, instance):setAnimation(8)
    GetNPCByID(ID.npc._JK1, instance):setAnimation(8)
    GetNPCByID(ID.npc._JK3, instance):setAnimation(8)

end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    local mob = GetMobByID(ID.mob[SEAGULL_GROUNDED].MOBS_START.EXCALIAC, instance)
    if mob ~= nil then
        onTrack(mob)
    end
    updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    assaultUtil.onInstanceFailure(instance, 102, ID.text)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)

    if progress > 0 then
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
