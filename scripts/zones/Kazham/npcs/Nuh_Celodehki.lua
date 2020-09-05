-----------------------------------
-- Area: Kazham
--  NPC: Nuh Celodehki
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Kazham/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4398,  993,    -- Fish Mithkabob
        4536, 3133,    -- Blackened Frog
        4410,  316,    -- Roast Mushroom
        4457, 2700,    -- Eel Kabob
    }

    player:showText(npc, ID.text.NUHCELODENKI_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
