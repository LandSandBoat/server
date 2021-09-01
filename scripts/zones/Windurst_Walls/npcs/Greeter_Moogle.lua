-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Greeter Moogle
-- !pos -203 -0.276 -139 239
-----------------------------------
require("scripts/globals/events/login_campaign")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local csid = 528
    xi.events.loginCampaign.onTrigger(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
    xi.events.loginCampaign.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
