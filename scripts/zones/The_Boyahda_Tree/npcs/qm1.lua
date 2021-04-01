-----------------------------------
-- Area: The Boyahda Tree (153)
--  NPC: qm1 (???)
-- Quests: Shoot First, Ask Questions Later (Detonator WSNM "Beet Leafhopper")
-- !pos -11 -19 -177 153
-----------------------------------
local ID = require("scripts/zones/The_Boyahda_Tree/IDs")
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.wsquest.handleQmTrigger(xi.wsquest.detonator, player, ID.mob.BEET_LEAFHOPPER)
end

return entity
