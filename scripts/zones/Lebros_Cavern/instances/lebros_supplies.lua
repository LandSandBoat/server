-----------------------------------
-- Assault: Lebros Supplies
-- Your mission is to deliver rations to each member of the advance unit.
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/instance")
require("scripts/globals/items")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/assault")
require("scripts/globals/zone")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    assaultUtil.afterInstanceRegister(player, 5345, ID.text, ID.mob)
end

instance_object.onInstanceCreated = function(instance)
    if math.random(1,100) >= 50 then
        GetMobByID(17035306, instance):setSpawn(-304.151, -8.470, -180.556, 250)
    end
    if math.random(1,100) >= 50 then
        GetMobByID(17035307, instance):setSpawn(-555.575, -10.872, -149.561, 201)
    end
    if math.random(1,100) >= 50 then
        GetMobByID(17035308, instance):setSpawn(-291.425, -8.264, -137.649, 142)
    end
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-330, -10, -262, 128)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-330, -10, -265, 128)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    assaultUtil.onInstanceFailure(instance, 102, ID.text)
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress >= 12 then
        instance:complete()
    end
end

instance_object.onInstanceComplete = function(instance)
    assaultUtil.onInstanceComplete(player, instance, 5, 10, ID.text, ID.npc)
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
    assaultUtil.instanceOnEventFinish(player, csid, 102, xi.zone.MOUNT_ZHAYOLM)
end

return instance_object
