-----------------------------------
-- Area: Mhaura (249)
-- Ambuscade_Tome : !pos -28.030 -15.500 52.279 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.ambuscade.onTradeTome(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.ambuscade.onTriggerTome(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.ambuscade.onEventUpdateTome(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.ambuscade.onEventFinishTome(player, csid, option, npc)
end

return entity
