-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: qm1 (???)
-- Quests: Methods Create Madness (Impulse Drive WSNM "Water Leaper")
-- !pos 107 0.7 -125.25 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.impulse_drive, player, ID.mob.WATER_LEAPER)
end

return entity
