-----------------------------------
-- Area: Lower Jeuno
--  NPC: Susu
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4647, 20000,    -- Scroll of Banishga II
        4683, 2030,     -- Scroll of Barblind
        4697, 2030,     -- Scroll of Barblindra
        4682, 780,      -- Scroll of Barparalyze
        4696, 780,      -- Scroll of Barparalyzra
        4681, 400,      -- Scroll of Barpoison
        4695, 400,      -- Scroll of Barpoisonra
        4684, 4608,     -- Scroll of Barsilence
        4698, 4608,     -- Scroll of Barsilencera
        4680, 244,      -- Scroll of Barsleep
        4694, 244,      -- Scroll of Barsleepra
        4628, 8586,     -- Scroll of Cursna
        4629, 35000,    -- Scroll of Holy
        4625, 2330,     -- Scroll of Silena
        4626, 19200,    -- Scroll of Stona
        4627, 13300,    -- Scroll of Viruna
    }

    player:showText(npc, ID.text.WAAG_DEEG_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
