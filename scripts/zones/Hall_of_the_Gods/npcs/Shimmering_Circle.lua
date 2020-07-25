-----------------------------------
-- Area: Hall of the Gods
--  NPC: Shimmering Circle
-- Lifts players up to the sky!
-- !pos 0 -20 147 251
-----------------------------------
local ID = require("scripts/zones/Hall_of_the_Gods/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local roz = player:getCurrentMission(ZILART)
    local rozStat = player:getCharVar("ZilartStatus")

    if player:getZPos() < 200 then
        if roz == tpz.mission.id.zilart.THE_GATE_OF_THE_GODS and rozStat == 0 then
            player:startEvent(3) -- First time.
        elseif
            roz ~= tpz.mission.id.zilart.NONE and
            (
                roz > tpz.mission.id.zilart.THE_GATE_OF_THE_GODS or
                (
                    roz == tpz.mission.id.zilart.THE_GATE_OF_THE_GODS and
                    rozStat > 0
                )
             )
        then
            player:startEvent(10)
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    else
        player:startEvent(11)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 3 then
        player:setCharVar("ZilartStatus", 1)
    end
end
