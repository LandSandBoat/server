-----------------------------------
-- Area: Mamook
--  NPC: Mahogany Door (Mumool Ja Ja Arena)
-- !pos -237.5 17.6 -380
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local item = xi.items.MAMOOK_SILVERSCALE_KEY

    if
        player:getXPos() >= -239.2 and
        npcUtil.tradeHas(trade, { item, item + 1, item + 2 })
    then
        player:confirmTrade()
        npc:openDoor(15)
        player:messageSpecial(zones[npc:getZoneID()].text.KEYS_SHATTER, item, item + 1, item + 2)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getXPos() <= -240.5 and
        npc:getAnimation() == xi.anim.CLOSE_DOOR
    then
        player:startEvent(220)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 220 and
        option == 1
    then
        player:setPos(-234.5, 17.6, -380, 0, 65) -- Warp to the outside of the door
    end
end

return entity
