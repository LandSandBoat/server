-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: _0q1 (Sewer Entrance)
-- !pos 28 -12 44 26
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY) then
        player:startEvent(502)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 502 and option == 1 then
        player:setPos(260.068, 0, -283.568, 190, 27) -- To Phomiuna Aqueducts (R)
    end
end

return entity
