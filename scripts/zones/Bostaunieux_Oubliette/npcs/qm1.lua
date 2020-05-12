-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  NPC: qm1 (???)
-- Quests: The Walls of Your Mind (Asuran Fists WSNM "Bodach")
-- !pos 20 17 -140 236
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/wsquest")
-----------------------------------

function onTrigger(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.asuran_fists, player, ID.mob.BODACH)
end
