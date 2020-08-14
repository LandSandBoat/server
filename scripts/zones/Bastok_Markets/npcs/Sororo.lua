-----------------------------------
-- Area: Bastok Markets
--  NPC: Sororo
-- Standard Merchant NPC
-- !pos -220.217 -2.824 51.542 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")

function onTrigger(player, npc)
    local stock =
    {
        4641,  1165, 1, -- Diaga
        4662,  7025, 1, -- Stoneskin
        4664,   837, 1, -- Slow
        4610,   585, 2, -- Cure II
        4636,   140, 2, -- Banish
        4646,  1165, 2, -- Banishga
        4661,  2097, 2, -- Blink
        4608,    61, 3, -- Cure
        4615,  1363, 3, -- Curaga
        4622,   180, 3, -- Poisona
        4623,   324, 3, -- Paralyna
        4624,   990, 3, -- Blindna
        4606,    82, 3, -- Dia
        4651,   219, 3, -- Protect
        4656,  1584, 3, -- Shell
        4721, 29700, 3, -- Repose
    }

    player:showText(npc, ID.text.SORORO_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end
