-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Urbiolaine
--  Unity NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getNumEminenceCompleted() < 10 then
        player:startEvent(3528)

    -- Check for "All for One"
    elseif not player:hasEminenceRecord(5) then
        player:startEvent(3525)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
