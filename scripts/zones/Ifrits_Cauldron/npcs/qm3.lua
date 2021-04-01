-----------------------------------
-- Area: Ifrit's Cauldron (205)
--  NPC: qm3 (???)
-- Quests: Blood and Glory (Retribution WSNM "Cailleach Bheur")
-- !pos 119 20 144 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.wsquest.handleQmTrigger(xi.wsquest.retribution, player, ID.mob.CAILLEACH_BHEUR)
end

return entity
