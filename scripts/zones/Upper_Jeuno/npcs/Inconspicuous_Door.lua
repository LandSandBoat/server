-----------------------------------
-- Area: Upper Jeuno (244)
--  NPC: Inconspicuous Door
-- A Moogle Kupo d'Etat Mission NPC
-- !pos -15 1.300 68 244
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
