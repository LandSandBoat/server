-----------------------------------
-- Area: Southern San d'Oria [S]
--  NPC: Renadile
-- Armor Storage NPC
-----------------------------------
require("scripts/globals/armorstorage")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.armorStorage.onTrade(player, trade, 626)
end

function onTrigger(player, npc)
    tpz.armorStorage.onTrigger(player, 627)
end

function onEventUpdate(player, csid, option)
    tpz.armorStorage.onEventUpdate(player, csid, option, 627)
end

function onEventFinish(player, csid, option)
    tpz.armorStorage.onEventFinish(player, csid, option, 626, 627)
end
