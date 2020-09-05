-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ratonne
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 510)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 511)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 511)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 510, 511)
end
