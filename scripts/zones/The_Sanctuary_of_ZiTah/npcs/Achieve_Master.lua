-----------------------------------
-- Area: The Sanctuary of Zi'Tah
-- NPC: Achieve Master
-- !pos 103.6530 0.0400 -405.7394
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.failBadge.onTradeZitah(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerZitah(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity