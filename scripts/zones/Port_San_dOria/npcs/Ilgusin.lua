-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ilgusin
-- !pos -68.313 -6.5 -36.985 232
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(591)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
