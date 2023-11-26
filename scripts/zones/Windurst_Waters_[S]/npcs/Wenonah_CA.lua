-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Wenonah, C.A.
-- Type: Campaign Teleporter
-- !pos -2.175 -2 10.184 94
-----------------------------------
require('scripts/globals/teleports/campaign_teleports')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.campaign.teleports.teleporterOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.campaign.teleports.teleporterOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.campaign.teleports.teleporterOnEventFinish(player, csid, option)
end

return entity
