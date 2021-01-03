-----------------------------------
-- Against All Odds
-- Cor AF2
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, tpz.ki.LIFE_FLOAT)
    player:delKeyItem(tpz.ki.LIFE_FLOAT)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    for i, v in pairs(ID.mob[54]) do
        SpawnMob(v, instance)
    end
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)

    if (progress == 2) then
        instance:complete()
    end

end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if v:getCharVar("AgainstAllOdds") == 2 then
            v:setCharVar("AgainstAllOdds", 3)
        end
        v:startEvent(101)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
