-----------------------------------
-- Area: Mhaura (249)
-- Gorpa-Masorpa  : !pos -27.584 -15.990 52.565 249
-----------------------------------
require("scripts/globals/ambuscade")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.ambuscade.onTradeGorpaMasorpa(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.ambuscade.onTriggerGorpaMasorpa(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.ambuscade.onEventUpdateGorpaMasorpa(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.ambuscade.onEventFinishGorpaMasorpa(player, csid, option)
end

return entity
