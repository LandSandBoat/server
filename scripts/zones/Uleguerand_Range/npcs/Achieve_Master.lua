-----------------------------------
-- Area: Uleguerand Range
-- NPC: Achieve Master
-- !pos 540.2386 -43.8008 299.4552
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.failBadge.onTradeUleguerand(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerUleguerand(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity