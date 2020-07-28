-----------------------------------
-- Area: Lower Jeuno
--  NPC: Caruvinda
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 10046)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 10045)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 10045)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 10046, 10045)
end
