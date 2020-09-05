-----------------------------------
-- Area: Cape Teriggan
--  NPC: qm1 (???)
-- Quests: From Saplings Grow (Empyreal Arrow WSNM "Stolas")
-- !pos -157 -8 198.2 113
-----------------------------------
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Cape_Teriggan/IDs")

function onTrigger(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.empyreal_arrow, player, ID.mob.STOLAS)
end
