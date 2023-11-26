-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Soimin-Oimin, C.C.
-- Type: Campaign Arbiter
-- https://ffxiclopedia.fandom.com/wiki/Campaign_Arbiter
-- Type: Retrace
-- !pos -51.010 -6.276 213.678 94
-----------------------------------
require('scripts/globals/teleports/campaign_teleports')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.campaign.teleports.campaignArbiterOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.campaign.teleports.campaignArbiterOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.campaign.teleports.campaignArbiterOnEventFinish(player, csid, option)
end

return entity
