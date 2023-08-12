-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Collione
--  General Info NPC
-- !pos 10 2 -66 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(859)
-- player:startEvent(854)  --chocobo dig game
-- player:startEvent(856)  -- play the chocobo game
-- player:startEvent(857)  -- rules for choc game
-- player:startEvent(858)  -- cant give more greens
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
