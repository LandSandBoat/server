-----------------------------------
-- Area: Metalworks
--  NPC: Lexun-Maxirun, W.W.
-- !pos 28 -16 28 237
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.WINDURST
local guardType   = xi.conquest.guard.FOREIGN
local guardEvent  = 32759

entity.onTrade = function(player, npc, trade)
    xi.conquest.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conquest.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conquest.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conquest.overseerOnEventFinish(player, csid, option, guardNation, guardType)
end

return entity
