-----------------------------------
-- Area: Bibiki Bay
--  NPC: ???
-- Note: Used to spawn Shen
-- !pos -115.108 0.300 -724.664 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shenId = player:getZone():queryEntitiesByName('Shen')[1]:getID()
    if
        npcUtil.tradeHasExactly(trade, xi.item.SHRIMP_LANTERN) and
        npcUtil.popFromQM(player, npc, shenId)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
