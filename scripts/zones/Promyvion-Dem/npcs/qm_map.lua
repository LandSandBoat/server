-----------------------------------
-- Area: Promyvion Dem
--  NPC: ??? (map acquisition)
-- TODO: QM moves every 20-30 minutes. need retail cap of all possible positions
-- known positions include:
-- !pos 319.996 -2.330 -80.000 18
-- !pos 159.998 -2.327 0.000 18
-----------------------------------
local ID = require("scripts/zones/Promyvion-Dem/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1721) and not player:hasKeyItem(tpz.ki.MAP_OF_PROMYVION_DEM) then
        player:startEvent(49)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 49 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, tpz.ki.MAP_OF_PROMYVION_DEM)
    end
end
