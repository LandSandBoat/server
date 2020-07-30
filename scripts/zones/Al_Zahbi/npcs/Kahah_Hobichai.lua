-----------------------------------
-- Area: Al Zahbi
--  NPC: Kahah Hobichai
-- Standard Merchant NPC
-- TODO: Stock needs to be modified based on
--       status of Astral Candescence
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        90,     200,    -- Rusty Bucket
        605,    200,    -- Pickaxe (Requires Astral Candescence)
        1020,   300,    -- Sickle (Requires Astral Candescence)
        1021,   500,    -- Hatchet (Requires Astral Candescence)
        16465,  164,    -- Bronze Knife
        16466, 2425     -- Knife
    }

    player:showText(npc, ID.text.KAHAHHOBICHAI_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
