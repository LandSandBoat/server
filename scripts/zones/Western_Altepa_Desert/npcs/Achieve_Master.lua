-----------------------------------
-- Area: Western Altepa Desert
-- NPC: Achieve Master
-- !pos -212.2397 -14.8012 -15.2794
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.failBadge.onTradeAltepa(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerAltepa(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity