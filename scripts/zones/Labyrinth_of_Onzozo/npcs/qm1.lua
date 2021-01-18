-----------------------------------
-- Area: Labyrinth of Onzozo
--  NPC: qm1 (???)
-- Quests: Bugi Soden (Blade: Ku WSNM "Megapod Megalops")
-- !pos 110 15 162 213
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.blade_ku, player, ID.mob.MEGAPOD_MEGALOPS)
end

return entity
