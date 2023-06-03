-----------------------------------
-- Area: Halvung
--  NPC: Decorative Bronze Gate (_1qp)
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade,
        {
            xi.items.HALVUNG_SHAKUDO_KEY,
            xi.items.HALVUNG_BRONZE_KEY,
            xi.items.HALVUNG_BRASS_KEY
        })
    then
        player:confirmTrade()
        npc:openDoor()
        player:messageSpecial(ID.text.KEY_BREAKS,
            xi.items.HALVUNG_SHAKUDO_KEY,
            xi.items.HALVUNG_BRONZE_KEY,
            xi.items.HALVUNG_BRASS_KEY
        )
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 79.75 and npc:getAnimation() == xi.anim.CLOSE_DOOR then -- from inside the door
        npc:openDoor()
    else
        player:messageSpecial(ID.text.WIDE_TRENCH)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
