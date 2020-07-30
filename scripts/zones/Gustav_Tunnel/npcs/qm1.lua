-----------------------------------
-- Area: Gustav tunnel (212)
--  NPC: qm1 (???)
-- Quests: Cloak and Dagger (Evisceration WSNM "Baronial Bat")
-- !pos 52.8, -1, 19.9 212
-----------------------------------
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Gustav_Tunnel/IDs")

function onTrigger(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.evisceration, player, ID.mob.BARONIAL_BAT)
end
