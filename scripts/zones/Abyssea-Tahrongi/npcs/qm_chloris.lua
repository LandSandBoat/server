-----------------------------------
-- Zone: Abyssea-Tahrongi
--  NPC: qm_chloris (???)
-- Spawns Chloris
-- !pos 160 0 -15 45
-- !pos 160 0 0 45
-- !pos 160 0 -30 45
-----------------------------------
local ID = require('scripts/zones/Abyssea-Tahrongi/IDs')
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.CHLORIS_1, { xi.ki.TORN_BAT_WING, xi.ki.VEINOUS_HECTEYES_EYELID, xi.ki.MOSSY_ADAMANTOISE_SHELL, xi.ki.GORY_SCORPION_CLAW })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
