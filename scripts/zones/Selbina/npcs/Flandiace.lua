-----------------------------------
-- Area: Selbina
--  NPC: Flandiace
-- Type: Adventurer's Assistant
-- !pos 21.313 -15.558 84.298 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(12)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
