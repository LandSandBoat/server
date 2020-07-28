-----------------------------------
-- Area: Selbina
--  NPC: Chutarmire
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4768,  5751,    -- Scroll of Stone II
        4778,  8100,    -- Scroll of Water II
        4763, 11970,    -- Scroll of Aero II
        4753, 16560,    -- Scroll of Fire II
        4758, 21870,    -- Scroll of Blizzard II
        4773, 27900,    -- Scroll of Thunder II
        4797,  1165,    -- Scroll of Stonega
        4807,  2097,    -- Scroll of Waterga
        4792,  4147,    -- Scroll of Aeroga
        4782,  7025,    -- Scroll of Firaga
        4787, 10710,    -- Scroll of Blizzaga
        4802, 15120,    -- Scroll of Thundaga
        4829, 22680,    -- Scroll of Poison II
        4839, 12600,    -- Scroll of Bio II
        4833,  4644,    -- Scroll of Poisonga
        4859,  8100,    -- Scroll of Shock Spikes
    }

    player:showText(npc, ID.text.CHUTARMIRE_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
