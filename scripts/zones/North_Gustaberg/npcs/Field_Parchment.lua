-----------------------------------
-- Area: North Gustaberg
--  NPC: Field Parchment
-- Type: Fields of Valor NMs
-- !pos 400.000 -21.5 560.000 106
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(2001)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
