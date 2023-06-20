-----------------------------------
-- Area: Misareaux Coast
--  NPC: Spatial Displacement
-- Entrance to Riverne Site #A01 and #B01
-- !pos -540 -30 360 25
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT) then
        player:startEvent(551) -- Access to Sites A & B
    else
        player:startEvent(550) -- Access to Site A Only
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 551 or csid == 550) and option == 1 then
        player:setPos(732.55, -32.5, -506.544, 90, 30) -- Go to Riverne #A01 (R)
    elseif csid == 551 and option == 2 then
        player:setPos(729.749, -20.319, 407.153, 90, 29) -- Go to Riverne #B01 (R)
    end

    if csid > 0 then
        xi.teleport.clearEnmityList(player)
    end
end

return entity
