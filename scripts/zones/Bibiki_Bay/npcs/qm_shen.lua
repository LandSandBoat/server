-----------------------------------
-- Area: Bibiki Bay
--  NPC: ???
-- Note: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shenId = player:getZone():queryEntitiesByName("Shen")[1]:getID()
    if
        npcUtil.tradeHasExactly(trade, xi.items.SHRIMP_LANTERN) and
        npcUtil.popFromQM(player, npc, shenId)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
