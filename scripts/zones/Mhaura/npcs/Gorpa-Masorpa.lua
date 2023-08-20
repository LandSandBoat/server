-----------------------------------
-- Area: Mhaura (249)
-- Gorpa-Masorpa  : !pos -27.584 -15.990 52.565 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.ambuscade.onTradeGorpaMasorpa(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.ambuscade.onTriggerGorpaMasorpa(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.ambuscade.onEventUpdateGorpaMasorpa(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.ambuscade.onEventFinishGorpaMasorpa(player, csid, option, npc)
end

return entity
