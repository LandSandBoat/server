-----------------------------------
-- Assault: Leujaoam Cleansing
-----------------------------------
require("scripts/globals/instance")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.ASSAULT_01_START, 1)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)

    for i, v in pairs(ID.mob[1]) do
        SpawnMob(v, instance)
    end

    local rune = GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance)
    local box = GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance)
    rune:setPos(476, 8.479, 39, 49)
    box:setPos(476, 8.479, 40, 49)

    GetNPCByID(ID.npc._1XN, instance):setAnimation(8)

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

    if (progress >= 15) then
        instance:complete()
    end

end

instance_object.onInstanceComplete = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    local rune = GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance)
    local box = GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance)
    rune:setStatus(tpz.status.NORMAL)
    box:setStatus(tpz.status.NORMAL)

end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
