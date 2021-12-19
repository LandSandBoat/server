-----------------------------------
-- Area: Halvung
--  NPC: Decorative Bronze Gate (_1qp)
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, {2221, 2222, 2223}) then
        player:confirmTrade()
        npc:openDoor()
        player:messageSpecial(ID.text.KEY_BREAKS, 2221,2222,2223)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 79 and npc:getAnimation() == xi.anim.CLOSE_DOOR then -- from inside the door
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
