-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_itzpapalotl_2 (???)
-- Spawns Itzpapalotl
-- !pos 424.940 20.220 -194.227 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ITZPAPALOTL_OFFSET + 4, { xi.ki.VENOMOUS_WAMOURA_FEELER, xi.ki.BULBOUS_CRAWLER_COCOON, xi.ki.DISTENDED_CHIGOE_ABDOMEN })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
