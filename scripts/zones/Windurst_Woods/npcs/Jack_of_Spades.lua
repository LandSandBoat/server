-----------------------------------
-- Area: Windurst Woods
--  NPC: Jack of Spades
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 536) then -- adventurer coupon
        player:startEvent(10010, GIL_RATE * 50)
    end
end

function onTrigger(player, npc)
    player:startEvent(10009, 0, 4)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10010 then
        player:confirmTrade()
        player:addGil(GIL_RATE * 50)
    end
end
