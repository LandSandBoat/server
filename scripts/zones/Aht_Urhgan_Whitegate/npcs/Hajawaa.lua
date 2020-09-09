-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Hajawaa
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 703)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 704)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 704)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 703, 704)
end
