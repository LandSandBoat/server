-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Leaufetie, R.K.
-- Type: Conquest Overseer
-- !pos -227.956 -81.475 260.442 111
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.SANDORIA
local guardType   = xi.conquest.guard.BORDER
local guardRegion = xi.region.FAUREGANDI
local guardEvent  = 32762

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
