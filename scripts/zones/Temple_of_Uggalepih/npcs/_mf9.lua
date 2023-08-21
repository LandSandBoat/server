-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: _mf9 (Granite Door)
-- Notes: Opens with Prelate Key
-- !pos -60 -8 -99 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.PRELATE_KEY) then -- Prelate Key
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, xi.item.PRELATE_KEY)
        npc:openDoor(6.5)
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() > -62 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, xi.item.PRELATE_KEY)
    else
        npc:openDoor(11) -- retail timed
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
