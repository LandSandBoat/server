-----------------------------------
-- Area: Toraimarai Canal
--  NPC: Tome of Magic ( Needed for Mission )
-- Involved In Windurst Mission 7-1
-- !zone 169
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset = npc:getID() - ID.npc.TOME_OF_MAGIC_OFFSET

    if offset == 4 and player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_SIXTH_MINISTRY and player:getCharVar("MissionStatus") == 1 then
        player:startEvent(69)
    elseif offset >= 0 and offset <= 3 then
        player:startEvent(65 + offset)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 69 then
        player:setCharVar("MissionStatus", 2)
    end
end
