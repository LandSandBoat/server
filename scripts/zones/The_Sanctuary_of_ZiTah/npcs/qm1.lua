-----------------------------------
-- Area: The Sanctuary of Zi'Tah (121)
--  NPC: qm1 (???)
-- Quests: The Weight of Your Limits (Steel Cyclone WSNM "Greenman")
-- !pos -324 1 474 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.wsquest.handleQmTrigger(tpz.wsquest.steel_cyclone, player, ID.mob.GREENMAN)
end

return entity
