-----------------------------------
-- Area: Windurst Woods
--  NPC: Tesch_Garanjy
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 10027)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 10028)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 10028)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 10027, 10028)
end
