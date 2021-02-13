-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Peddlestox
-- !pos -499.914 1.470 -109.039 124
-- Active on LIGHTNINGDAY in this zone. To test on off-days, setStatus(tpz.status.NORMAL)
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
require("scripts/globals/beastmentreasure")
-----------------------------------
local entity = {}

entity.onTrigger = function(player)
    tpz.bmt.handleNpcOnTrigger(player, ID.npc.BEASTMEN_TREASURE)
end

entity.onTrade = function(player, npc, trade)
    tpz.bmt.handleNpcOnTrade(player, trade, ID.npc.BEASTMEN_TREASURE)
end

entity.onEventFinish = function(player, csid, option)
    tpz.bmt.handleNpcOnEventFinish(player, csid)
end

return entity
