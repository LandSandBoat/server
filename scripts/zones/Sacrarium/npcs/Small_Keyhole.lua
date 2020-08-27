-----------------------------------
--  NPC: Small Keyhole
-- Area: Sacrarium
-- !pos 99.772 -1.614 51.545 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.TEMPLE_KNIGHT_KEY) then
        GetNPCByID(npc:getID() - 3):openDoor(15)
    else
        player:messageSpecial(ID.text.SMALL_KEYHOLE_DESCRIPTION)
    end
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1659) then
        if npc:getLocalVar("canTradeSecondKey") == 0 then
            npc:setLocalVar("canTradeSecondKey", 1)
            player:startEvent(100)
        else
            player:messageSpecial(ID.text.CANNOT_TRADE_NOW)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 100 then
        GetNPCByID(ID.npc.SMALL_KEYHOLE):setLocalVar("canTradeSecondKey", 0)
        player:messageSpecial(ID.text.CORAL_KEY_BREAKS, 0, 1659)
        player:confirmTrade()
    end
end
