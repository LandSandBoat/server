-----------------------------------
-- Area: Jugner Forest
--  NPC: Bubchu-Bibinchu, W.W.
-- Type: Outpost Conquest Guards
-- !pos 60.087 -0.602 -11.847 104
-----------------------------------
---@type TNpcEntity
local entity = {}

local guardNation = xi.nation.WINDURST
local guardType   = xi.conquest.guard.OUTPOST
local guardRegion = xi.region.NORVALLEN
local guardEvent  = 32759

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
