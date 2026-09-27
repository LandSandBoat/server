-----------------------------------
-- Area: Xarcabard [S]
--  NPC: Estaud, R.K.
-- Type: Campaign Arbiter (return trip to player's own nation of allegiance)
-- !pos 135.152 -22.066 -116.423 137
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
