-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Pihra_Rhebenslo
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 442)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 443)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 443)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 442, 443)
end
