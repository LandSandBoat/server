-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Mindala-Andola C.C.
-- Type: Sigil NPC
-- !pos -31.869 -6.009 226.793 94
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.campaign.sigilOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.campaign.sigilOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.campaign.sigilOnEventFinish(player, csid, option, npc)
end

return entity
