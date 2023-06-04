-----------------------------------
-- Area: Windurst Woods
--  NPC: Jack of Spades
-- Adventurer's Assistant
-----------------------------------
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 536) then -- adventurer coupon
        player:startEvent(10010, xi.settings.main.GIL_RATE * 50)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10009, 0, 4)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10010 then
        player:confirmTrade()
        player:addGil(xi.settings.main.GIL_RATE * 50)
    end
end

return entity
