-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Taulenne
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 772)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 773)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 773)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 772, 773)
end
