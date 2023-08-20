-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Bonanza Moogle
-- !pos TODO
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.mogBonanza.onBonanzaMoogleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.events.mogBonanza.onBonanzaMoogleTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.events.mogBonanza.onBonanzaMoogleEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.events.mogBonanza.onBonanzaMoogleEventFinish(player, csid, option, npc)
end

return entity
