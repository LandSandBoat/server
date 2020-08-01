-----------------------------------
-- Area: Bibiki Bay
--  NPC: Pohka Chichiyowahl
-- Type: Standard Merchant NPC
-- !pos -415 -2 -430 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17388,  1238, 3,    -- Fastwater F. Rod
        17382, 11845, 3,    -- S.H. Fishing Rod
        4148,    290, 3,    -- Antidote
    }

    player:showText(npc, ID.text.POHKA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.WINDURST)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
