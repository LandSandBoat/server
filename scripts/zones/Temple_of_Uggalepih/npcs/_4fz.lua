-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- Leads to painbrush room @ F-7
-- !pos 60 0.1 8 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.UGGALEPIH_KEY) and
        player:getZPos() < 11
    then
        player:startEvent(46)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < 11 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, xi.item.UGGALEPIH_KEY)
    else
        player:startEvent(47)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 46 then
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, xi.item.UGGALEPIH_KEY)
    end
end

return entity
