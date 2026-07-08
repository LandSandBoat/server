-----------------------------------
-- Area: Port San d'Oria (232)
--  NPC: Greeter Moogle
-- !pos 62.5 -16 -126.713 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local csid = 806
    xi.events.loginCampaign.onTrigger(player, csid)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.events.loginCampaign.onEventUpdate(player, csid, option, npc)
end

return entity
