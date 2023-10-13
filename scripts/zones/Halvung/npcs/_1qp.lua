-----------------------------------
-- Area: Halvung
--  NPC: Decorative Bronze Gate (_1qp)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local item = xi.items.HALVUNG_SHAKUDO_KEY

    if npcUtil.tradeHasExactly(trade, { item, item + 1, item + 2 }) then
        player:confirmTrade()
        npc:openDoor(15)
        player:messageSpecial(zones[npc:getZoneID()].text.KEY_BREAKS, item, item + 1, item + 2)
    end
end

entity.onTrigger = function(player, npc)
    -- All other Beastman HNM have events that teleport them out of the room
    -- **Event call is unknown***
    if
        player:getZPos() <= 79.75 and
        npc:getAnimation() == xi.anim.CLOSE_DOOR
    then
        -- player:startEvent(??)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
