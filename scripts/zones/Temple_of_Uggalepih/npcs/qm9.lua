-----------------------------------
-- Area: Temple of Uggalepih (159)
--  NPC: qm9 (???)
-- Quests: Axe the Competition (Decimation WSNM "Yallery Brown")
-- !pos 218 -8 206 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.decimation, player, ID.mob.YALLERY_BROWN)
end

return entity
