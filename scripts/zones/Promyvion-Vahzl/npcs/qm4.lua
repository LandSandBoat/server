-----------------------------------
-- Area: Promyvion-Vahzl
--  NPC: ??? (qm4)
-- Notes: Map Acquisition Floor 3
-- NPC ID: 16867714
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:messageSpecial(ID.text.EERIE_GREEN_GLOW)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1723) and not player:hasKeyItem(tpz.ki.MAP_OF_PROMYVION_VAHZL) then
        player:startEvent(48)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 48 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, tpz.ki.MAP_OF_PROMYVION_VAHZL)
    end
end