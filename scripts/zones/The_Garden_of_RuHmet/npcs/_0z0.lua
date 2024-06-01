-----------------------------------
-- Area: The_Garden_of_RuHmet
--  NPC: _0z0
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 3
    then
        player:startEvent(203)
    elseif
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 5
    then
        player:startEvent(205)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 203 then
        player:setCharVar('PromathiaStatus', 4)
    end
end

return entity
