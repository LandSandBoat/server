-----------------------------------
-- Area: Xarcabard [S]
--  NPC: Yimi Jomkeh, M.C.
-- Type: Campaign Arbiter (return trip to player's own nation of allegiance)
-- !pos 135.152 -22.066 -116.423 137
--
-- Default/teleport events, gating, and shared logic all live in
-- campaign_teleport.lua's zoneArbiterEvents table, keyed by this NPC's own
-- name -- see that file for the full explanation.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.campaignTeleport.zoneArbiterOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.campaignTeleport.zoneArbiterOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.campaignTeleport.zoneArbiterOnEventFinish(player, csid, option, npc)
end

return entity
