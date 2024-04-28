-----------------------------------
-- Type: Campaign Arbiter
-- https://ffxiclopedia.fandom.com/wiki/Campaign_Arbiter
-- !pos 113 1 -40 80
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
