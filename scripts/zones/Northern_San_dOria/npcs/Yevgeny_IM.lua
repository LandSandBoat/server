-----------------------------------
-- Area: Northern Sandoria
--  NPC: Yevgeny, I.M.
-- !pos 45 -1 0 231
-----------------------------------
local entity = {}

local guardNation = xi.nation.BASTOK
local guardType   = xi.conq.guard.FOREIGN
local guardEvent  = 32761

entity.onTrade = function(player, npc, trade)
    xi.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

entity.onTrigger = function(player, npc)
    xi.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType)
end

return entity
