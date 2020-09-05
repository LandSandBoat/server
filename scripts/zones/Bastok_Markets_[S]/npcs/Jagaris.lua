-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Jagaris
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 328)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 329)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 329)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 328, 329)
end
