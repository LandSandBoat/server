-----------------------------------
-- Area: Ro'Maeve (122)
-- NPC: qm1 (???)
-- Quests: Orastery Woes (Black Halo WSNM "Eldhrimnir")
-- !pos 197 -8 -27.5 122
-----------------------------------
require("scripts/globals/wsquest")
local ID = require("scripts/zones/RoMaeve/IDs")

function onTrigger(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.black_halo, player, ID.mob.ELDHRIMNIR)
end
