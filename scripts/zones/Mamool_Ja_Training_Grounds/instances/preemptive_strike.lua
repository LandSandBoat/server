-----------------------------------
--
-- Assault: Preemptive Strike
--
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/instance")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.ASSAULT_12_START, 12)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)

    for i, v in pairs(ID.mob[1]) do
        SpawnMob(v, instance)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-57, 1, -101, 49)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-57, 1, -104, 49)

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

    if (progress >= 13) then
        instance:complete()
    end

end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in chars:pairs() do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setStatus(tpz.status.NORMAL)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setStatus(tpz.status.NORMAL)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
