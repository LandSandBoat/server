-----------------------------------
-- Area: Batok Markets
--  NPC: Zaira
-- Standard Merchant NPC
-- !pos -217.316 -2.824 49.235 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        4862,  114, 1,    -- Scroll of Blind
        4838,  360, 2,    -- Scroll of Bio
        4828,   82, 2,    -- Scroll of Poison
        4861, 2250, 2,    -- Scroll of Sleep
        4767,   61, 3,    -- Scroll of Stone
        4777,  140, 3,    -- Scroll of Water
        4762,  324, 3,    -- Scroll of Aero
        4752,  837, 3,    -- Scroll of Fire
        4757, 1584, 3,    -- Scroll of Blizzard
        4772, 3261, 3,    -- Scroll of Thunder
        4847, 1363, 3,    -- Scroll of Shock
        4846, 1827, 3,    -- Scroll of Rasp
        4845, 2250, 3,    -- Scroll of Choke
        4844, 3688, 3,    -- Scroll of Frost
        4843, 4644, 3,    -- Scroll of Burn
        4848, 6366, 3,    -- Scroll of Drown
    }

    player:showText(npc, ID.text.ZAIRA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
