-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Wanzo-Unzozo
-- Type: Quest NPC (Escort for Hire - Windurst)
-- !pos -381 -12 398
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/quests")
-----------------------------------
local ID = require('scripts/zones/Garlaige_Citadel/IDs')
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
end

entity.onDeath = function(npc)
end

return entity
