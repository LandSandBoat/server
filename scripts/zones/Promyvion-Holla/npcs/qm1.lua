-----------------------------------
-- Area: Promyvion holla
-- ??? map acquisition
-----------------------------------
local ID = require("scripts/zones/Promyvion-Holla/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1720) and not player:hasKeyItem(tpz.ki.MAP_OF_PROMYVION_HOLLA) then
        npcUtil.giveKeyItem(player, tpz.ki.MAP_OF_PROMYVION_HOLLA)
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
