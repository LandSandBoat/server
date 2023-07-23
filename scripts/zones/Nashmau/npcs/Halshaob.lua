-----------------------------------
-- Area: Nashmau
--  NPC: Halshaob
-- Type: Quest NPC
-- !pos 28.537 -7 -85.250 53
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(299)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
