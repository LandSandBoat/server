-----------------------------------
-- Area: Rabao
--  NPC: Brave Wolf
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12301, 31201,    -- Buckler
        12302, 60260,    -- Darksteel Buckler
        13979, 24373,    -- Silver Bangles
        12554, 66066,    -- Banded Mail
        12682, 35285,    -- Mufflers
        12810, 52552,    -- Breeches
        12938, 32382,    -- Sollerets
        12609,  9423,    -- Black Tunic
        12737,  4395,    -- White Mitts
        12865,  6279,    -- Black Slacks
        12993,  4084,    -- Sandals
        12578, 28654,    -- Padded Armor
        12706, 15724,    -- Iron Mittens
        12836, 23063,    -- Iron Subligar
        12962, 14327,    -- Leggins
    }

    player:showText(npc, ID.text.BRAVEWOLF_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
