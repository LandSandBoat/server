-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: _mf8 (Granite Door)
-- Note: Opens with Uggalepih Key
-- !pos -208 -1.89 -20
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, xi.item.UGGALEPIH_KEY) then
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, xi.item.UGGALEPIH_KEY)
        npc:openDoor()
    end
end

entity.onTrigger = function(player, npc)
    if player:getXPos() >= -208 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, xi.item.UGGALEPIH_KEY)
    else
        npc:openDoor(11)
    end
end

return entity
