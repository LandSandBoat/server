-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_itzpapalotl_3 (???)
-- Spawns Itzpapalotl
-- !pos 439.940 21.020 -179.227 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ITZPAPALOTL_OFFSET + 8, { xi.keyItem.VENOMOUS_WAMOURA_FEELER, xi.keyItem.BULBOUS_CRAWLER_COCOON, xi.keyItem.DISTENDED_CHIGOE_ABDOMEN })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
