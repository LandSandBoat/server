-----------------------------------
-- Area: Lower Jeuno
--  NPC: Matoaka
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        13327, 1250,    -- Silver Earring
        13456, 1250,    -- Silver Ring
        13328, 4140,    -- Mythril Earring
    }

    player:showText(npc, ID.text.MATOAKA_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
