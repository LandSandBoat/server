-----------------------------------
-- Area: Ifrit's Cauldron
-- NPC: Achieve Master
-- !pos 30.6501 19.3100 -20.8047
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.failBadge.onTradeIfrits(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerIfrits(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity