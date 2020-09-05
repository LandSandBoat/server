-----------------------------------
--
-- TOAU-42: Path of Darkness
--
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    SpawnMob(ID.mob[59].RAUBAHN, instance)
    SpawnMob(ID.mob[59].RAZFAHD, instance)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

function onInstanceProgressUpdate(instance, progress)
    if (progress == 4) then
        local chars = instance:getChars()

        for i, v in pairs(chars) do
            v:startEvent(203)
        end

        DespawnMob(ID.mob[59].RAZFAHD, instance)
        SpawnMob(ID.mob[59].ALEXANDER, instance)

    elseif(progress == 5) then
        instance:complete()
    end
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCurrentMission(TOAU) == tpz.mission.id.toau.NASHMEIRAS_PLEA and v:getCharVar("AhtUrganStatus") == 1) then
            v:setCharVar("AhtUrganStatus", 2)
        end

        v:setPos(0, 0, 0, 0, 72)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("Update CSID: %u", csid)
    -- printf("Update RESULT: %u", option)
end

function onEventFinish(player, csid, option)
    -- printf("Finish CSID: %u", csid)
    -- printf("Finish RESULT: %u", option)

    if(csid == 203) then
        player:setPos(-444, -4, 420, 127)
    end
end
