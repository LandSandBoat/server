-----------------------------------
-- Area: Bibiki Bay
--  NPC: Toh Zonikki
-- Type: Clamming NPC
-- !pos -371 -1 -421 4
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.clamming.zonikkiOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.clamming.zonikkiOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.clamming.zonikkiOnEventFinish(player, csid, option, npc)
end

return entity
