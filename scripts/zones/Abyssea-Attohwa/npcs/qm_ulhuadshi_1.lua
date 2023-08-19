-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm_ulhuadshi_1 (???)
-- Spawns Ulhuadshi
-- !pos 350.692 19.455 209.839 215
-----------------------------------
local ID = zones[xi.zone.ABYSSEA_ATTOHWA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ULHUADSHI_1, { xi.ki.MUCID_WORM_SEGMENT, xi.ki.SHRIVELED_HECTEYES_STALK })
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.qmOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.qmOnEventFinish(player, csid, option, npc)
end

return entity
