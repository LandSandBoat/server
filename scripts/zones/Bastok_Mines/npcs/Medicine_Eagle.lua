-----------------------------------
-- Area: Bastok Mines
--  NPC: Medicine Eagle
-- Involved in Mission: Bastok 6-1, 8-1
-- !pos -40 0 38 234
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and player:getCharVar("MissionStatus") == 0) then
        player:startEvent(180)
    else
        player:startEvent(25)
    end

end

-- if Bastok Mission 8-1
-- 176
-- player:startEvent(180)
-- player:startEvent(181)
--1  25  176  181  180
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 180) then
        player:setCharVar("MissionStatus", 1)
    end
end
