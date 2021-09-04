-----------------------------------
-- Area: Port Bastok (236)
--  NPC: Greeter Moogle
-- !pos 40.5 8.5 -242.276 236
-----------------------------------
require("scripts/globals/events/login_campaign")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local csid = 425
    xi.events.loginCampaign.onTrigger(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
    xi.events.loginCampaign.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
