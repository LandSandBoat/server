-----------------------------------
-- Area: Arrapago Reef
-- Door: Tidal Gate (Medusa Arena)
-- !pos -397 -15 420
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local item = xi.items.LAMIAN_CLAW_KEY

    if
        player:getXPos() >= -405 and
        npcUtil.tradeHasExactly(trade, { item, item + 1, item + 2 })
    then
        player:confirmTrade()
        npc:openDoor(15)
        player:messageSpecial(zones[npc:getZoneID()].text.KEYS_SHATTER, item, item + 1, item + 2)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getXPos() <= -407 and
        npc:getAnimation() == xi.anim.CLOSE_DOOR
    then
        player:startEvent(229)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 229 and
        option == 1
    then
        player:setPos(-90.910, -2.645, -612.908, 192, 54) -- Teleports far away from door
    end
end

return entity
