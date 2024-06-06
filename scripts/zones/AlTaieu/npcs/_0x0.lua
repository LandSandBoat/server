-----------------------------------
-- Area: Al'Taieu
--  NPC: Crystalline Field
-- !pos .1 -10 -464 33
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Set the PromathiaStatus to 3 if they did all 3 towers for GARDEN_OF_ANTIQUITY
    if player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.GARDEN_OF_ANTIQUITY then
        player:startEvent(100) -- Teleport inside
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 100 and option == 1 then
        player:setPos(-20, 0.624, -355, 191, 34) -- (R)
    end
end

return entity
