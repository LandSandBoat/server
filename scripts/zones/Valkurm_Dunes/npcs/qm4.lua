-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm4 (???)
-- Involved in quest: Pirate's Chart
-- !pos -160 4 -131 103
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MONSTERS_KILLED_ADVENTURERS)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
