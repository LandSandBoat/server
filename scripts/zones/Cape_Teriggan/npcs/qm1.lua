-----------------------------------
-- Area: Cape Teriggan
--  NPC: qm1 (???)
-- Quests: From Saplings Grow (Empyreal Arrow WSNM "Stolas")
-- !pos -157 -8 198.2 113
-----------------------------------
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Cape_Teriggan/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.wsquest.handleQmTrigger(xi.wsquest.empyreal_arrow, player, ID.mob.STOLAS)
end

return entity
