-----------------------------------
-- Area: Bastok Mines
--  NPC: Gonija
-- Type: Chocobo Breeder
-- !pos 28 0 -105 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(534)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
