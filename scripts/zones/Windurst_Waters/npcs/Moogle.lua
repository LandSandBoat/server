-----------------------------------
-- Area: Windurst Waters
--  NPC: Moogle
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.moghouse.moogleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.moghouse.moogleTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.moghouse.moogleEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.moghouse.moogleEventFinish(player, csid, option, npc)
end

return entity
