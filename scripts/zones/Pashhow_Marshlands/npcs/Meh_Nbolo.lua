-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Meh Nbolo
-- Type: Armor Storer
-- !pos 80.899 23.999 176.643 109
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(27)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
