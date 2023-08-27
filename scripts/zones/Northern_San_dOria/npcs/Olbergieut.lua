-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Olbergieut
-- Type: Quest NPC
-- !pos 91 0 121 231
-- Starts and Finishes Quest: Gates of Paradise
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
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
