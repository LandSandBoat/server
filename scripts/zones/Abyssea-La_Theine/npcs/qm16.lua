-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm16 (???)
-- Spawns Briareus
-- !pos -170 7 269 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 17318456, { xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
