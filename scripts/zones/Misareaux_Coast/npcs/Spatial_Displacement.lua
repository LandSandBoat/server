-----------------------------------
-- Area: Misareaux Coast
--  NPC: Spacial Displacement
-- Entrance to Riverne Site #A01 and #B01
-- !pos -540 -30 360 25
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    -- COP 4-2
    if player:getCurrentMission(COP) == xi.mission.id.cop.THE_SAVAGE and player:getCharVar("PromathiaStatus") == 0 then
        player:startEvent(8)
    -- COP 4-1
    elseif player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT) then
        player:startEvent(551) -- Access to Sites A & B
    else
        player:startEvent(550) -- Access to Site A Only
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if csid == 8 then
        player:setCharVar("PromathiaStatus", 1)
        player:setPos(732.55, -32.5, -506.544, 90, 30) -- Go to Riverne #A01 {R}
    elseif (csid == 551 or csid == 550) and option == 1 then
        player:setPos(732.55, -32.5, -506.544, 90, 30) -- Go to Riverne #A01 {R}
    elseif csid == 551 and option == 2 then
        player:setPos(729.749, -20.319, 407.153, 90, 29) -- Go to Riverne #B01 {R}
    end

end

return entity
