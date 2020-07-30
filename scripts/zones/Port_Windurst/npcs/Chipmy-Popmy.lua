-----------------------------------
-- Area: Port Windurst
--  NPC: Chipmy-Popmy
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local currentday = tonumber(os.date("%j"))
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("PromathiaStatus")==3 and player:getCharVar("Promathia_kill_day") ~= currentday and player:getCharVar("COP_3-taru_story")== 0 ) then
        player:startEvent(619)
    else
        player:startEvent(202)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 619) then
        player:setCharVar("COP_3-taru_story", 1)
    end
end
