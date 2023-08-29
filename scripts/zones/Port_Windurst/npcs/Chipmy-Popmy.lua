-----------------------------------
-- Area: Port Windurst
--  NPC: Chipmy-Popmy
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar('PromathiaStatus') == 3 and
        player:getCharVar('Promathia_kill_day') < os.time() and
        player:getCharVar('COP_3-taru_story') == 0
    then
        player:startEvent(619)
    else
        player:startEvent(202)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 619 then
        player:setCharVar('COP_3-taru_story', 1)
    end
end

return entity
