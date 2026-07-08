-----------------------------------
-- Area:  Nyzul_Isle
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.nyzul.tempBoxTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.nyzul.tempBoxFinish(player, csid, option, npc)
end

return entity
