-----------------------------------
-- Area: Mamook
--  NPC: _1t2 (Mahogany Door)
-- Notes:
--      Requires 3 keys: Silverscale, Tanscale, Blackscale
--      Stays open for 17s
--      Not openable from inside
--      Not pickable
-- !pos -240.000, 15.939, -380.000
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeMatches(trade, { { xi.item.MAMOOK_SILVERSCALE_KEY, 1 }, { xi.item.MAMOOK_TANSCALE_KEY, 1 }, { xi.item.MAMOOK_BLACKSCALE_KEY, 1 } }) and
        npc:getAnimation() == xi.animation.CLOSE_DOOR and
        player:getXPos() > -240.000
    then
        npc:openDoor(17) -- only open 17s per capture
        player:showText(npc, bit.bor(ID.text.KEYS_SHATTER, 0x8000), xi.item.MAMOOK_SILVERSCALE_KEY, xi.item.MAMOOK_TANSCALE_KEY, xi.item.MAMOOK_BLACKSCALE_KEY, -1, false, false)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.animation.CLOSE_DOOR then
        if player:getXPos() > -240.000 then
            player:messageText(npc, ID.text.KEYHOLE_THREE_COLORS, false, 6)
        else
            player:messageText(npc, ID.text.GATE_IS_FIRMLY_CLOSED, false, 6)
        end
    end
end

return entity
