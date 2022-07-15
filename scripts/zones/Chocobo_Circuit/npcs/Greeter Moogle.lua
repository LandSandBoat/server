-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Greeter Moodgle
-- Novice San d'Oria CRA Branch
-- pos -323.9516 0.0000 -480.2049
-----------------------------------
require("scripts/globals/events/login_campaign")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local csid = 500
    xi.events.loginCampaign.onTrigger(player, csid)
end

entity.onEventUpdate = function(player, csid, option)
    xi.events.loginCampaign.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
