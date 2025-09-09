-----------------------------------
-- Area: Provenance
-- NPC: Achieve Master
-- !pos -630.6863 -20.3667 -464.4673
-----------------------------------
require("modules/custom/lua/Fail_Badge_Quest")
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.failBadge.onTradeProvenance(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.failBadge.onTriggerProvenance(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity