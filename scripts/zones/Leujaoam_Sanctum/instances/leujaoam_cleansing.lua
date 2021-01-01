-----------------------------------
--
-- Assault: Leujaoam Cleansing
--
-----------------------------------
require("scripts/globals/instance")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.ASSAULT_01_START, 1)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)

    for i, v in pairs(ID.mob[1]) do
        SpawnMob(v, instance)
    end

    local rune = GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance)
    local box = GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance)
    rune:setPos(476, 8.479, 39, 49)
    box:setPos(476, 8.479, 40, 49)

    GetNPCByID(ID.npc._1XN, instance):setAnimation(8)

end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)

    local chars = instance:getChars()

    for i, v in chars:pairs() do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)

    if (progress >= 15) then
        instance:complete()
    end

end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in chars:pairs() do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    local rune = GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance)
    local box = GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance)
    rune:setStatus(tpz.status.NORMAL)
    box:setStatus(tpz.status.NORMAL)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
