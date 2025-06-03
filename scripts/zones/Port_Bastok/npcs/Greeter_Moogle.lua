-----------------------------------
-- Area: Port Bastok (236)
--  NPC: Greeter Moogle
-- !pos 40.5 8.5 -242.276 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local csid = 425
    xi.events.loginCampaign.onTrigger(player, csid)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.events.loginCampaign.onEventUpdate(player, csid, option, npc)
end

return entity
