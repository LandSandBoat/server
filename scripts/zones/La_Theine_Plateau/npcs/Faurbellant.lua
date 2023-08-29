-----------------------------------
-- Area: La Theine Plateau
--  NPC: Faurbellant
-- Type: Quest NPC
-- Involved in Quest: Gates of Paradise
-- !pos 484 24 -89 102
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
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
