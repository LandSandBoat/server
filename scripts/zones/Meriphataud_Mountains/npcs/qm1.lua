-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: qm1 (???)
-- Involved in Quest: The Holy Crest
-- !pos 641 -15 7 119
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1159) and player:getCharVar("TheHolyCrest_Event") == 4 then
        player:startEvent(56)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_FOUND)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 56 then
        player:setCharVar("TheHolyCrest_Event", 5)
        player:confirmTrade()
        player:startEvent(33)
    end
end
