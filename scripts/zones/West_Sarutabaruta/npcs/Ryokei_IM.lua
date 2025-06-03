-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Ryokei, I.M.
-- Type: Outpost Conquest Guards
-- !pos -11.322 -13.459 317.696 115
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.BASTOK
local guardType   = xi.conquest.guard.OUTPOST
local guardRegion = xi.region.SARUTABARUTA
local guardEvent  = 32761

entity.onTrade = function(player, npc, trade)
    xi.conquest.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conquest.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conquest.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conquest.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end

return entity
