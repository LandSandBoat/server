-----------------------------------
-- Area: Castle Zvahl Keep
-- NPC: Achieve Master
-- !pos -495.1968 -68 59.9066
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.failBadge.onTradeZvahl(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerZvahl(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity