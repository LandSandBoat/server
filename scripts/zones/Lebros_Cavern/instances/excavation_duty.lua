-----------------------------------
-- Assault: Excavation Duty
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/instance")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.ASSAULT_21_START, 21)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)

    for i, v in pairs(ID.mob[21]) do
        SpawnMob(v, instance)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(49.999, -40.837, 96.999, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(50.000, -40.070, 99.999, 0)

end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)

    if progress >= 5 then
        instance:complete()
    end

end

instance_object.onInstanceComplete = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED, 5, 10)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(tpz.status.NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(tpz.status.NORMAL)

end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
