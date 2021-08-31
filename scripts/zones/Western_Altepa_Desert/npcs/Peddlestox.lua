-----------------------------------
-- Area: Western Altepa Desert
--  NPC: Peddlestox
-- !pos 512.374 0.019 10.57 125
-- Active on EARTHSDAY in this zone. To test on off-days, setStatus(xi.status.NORMAL)
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/beastmentreasure")
-----------------------------------
local entity = {}

entity.onTrigger = function(player)
    xi.bmt.handleNpcOnTrigger(player, ID.npc.BEASTMEN_TREASURE)
end

entity.onTrade = function(player, npc, trade)
    xi.bmt.handleNpcOnTrade(player, trade, ID.npc.BEASTMEN_TREASURE)
end

entity.onEventFinish = function(player, csid, option)
    xi.bmt.handleNpcOnEventFinish(player, csid)
end

return entity
