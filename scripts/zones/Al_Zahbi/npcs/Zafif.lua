-----------------------------------
-- Area: Al Zahbi
--  NPC: Zafif
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4612, 23400,    -- Scroll of Cure IV
        4616, 11200,    -- Scroll of Curaga II
        4617, 19932,    -- Scroll of Curaga III
        4653, 32000,    -- Scroll of Protect III
        4654, 91116,    -- Scroll of Protect IV
        4736, 85500,    -- Scroll of Protectra IV
        4629, 35000,    -- Scroll of Holy
        4647, 20000,    -- Scroll of Banishga II
        4625,  2330,    -- Scroll of Silena
        4626, 19200,    -- Scroll of Stona
        4627, 13300,    -- Scroll of Viruna
        4628,  8586,    -- Scroll of Cursna
        4868, 77600,    -- Scroll of Dispell
        4720, 27000,    -- Scroll of Flash
        4750, 99375,    -- Scroll of Reraise III
        4715, 28500     -- Scroll of Reprisal
    }

    player:showText(npc, ID.text.ZAFIF_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
