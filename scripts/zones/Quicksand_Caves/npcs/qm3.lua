-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm3 (???)
-- Quests: Old Wounds (Savage Blade WSNM "Girtablulu")
-- !pos -145 2 446 208
-----------------------------------
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Quicksand_Caves/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.savage_blade, player, ID.mob.GIRTABLULU)
end

return entity
