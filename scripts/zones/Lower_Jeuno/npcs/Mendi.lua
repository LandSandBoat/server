-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mendi
-- Reputation NPC
-- !pos -55 5 -68 245
-----------------------------------
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(82, player:getFame(JEUNO))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
