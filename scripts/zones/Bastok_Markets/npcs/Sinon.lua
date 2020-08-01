-----------------------------------
-- Area: Bastok Markets
--  NPC: Sinon
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 395)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 396)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 396)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 395, 396)
end
