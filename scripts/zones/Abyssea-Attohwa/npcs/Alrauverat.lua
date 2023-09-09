-----------------------------------
-- NPC: Alrauverat
-- Zone: Abyssea - Attohwa
-- !pos 23 -0.744 126 215
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(388)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
