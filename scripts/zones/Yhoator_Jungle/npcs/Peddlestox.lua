-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Peddlestox
-- !pos -499.914 1.470 -109.039 124
-- Active on LIGHTNINGDAY in this zone. To test on off-days, setStatus(xi.status.NORMAL)
-----------------------------------
local ID = zones[xi.zone.YHOATOR_JUNGLE]
-----------------------------------
local entity = {}

entity.onTrigger = function(player)
    xi.bmt.handleNpcOnTrigger(player, ID.npc.BEASTMEN_TREASURE)
end

entity.onTrade = function(player, npc, trade)
    xi.bmt.handleNpcOnTrade(player, trade, ID.npc.BEASTMEN_TREASURE)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.bmt.handleNpcOnEventFinish(player, csid)
end

return entity
