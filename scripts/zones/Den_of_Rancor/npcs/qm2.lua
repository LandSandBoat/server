-----------------------------------
-- Area: Den of Rancor
--  NPC: qm2 (???)
-- Quests: Souls in Shadow (Spiral Hell WSNM "Mokumokuren")
-- !pos 118 36 -281 160
-----------------------------------
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Den_of_Rancor/IDs")

function onTrigger(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.spiral_hell, player, ID.mob.MOKUMOKUREN)
end
