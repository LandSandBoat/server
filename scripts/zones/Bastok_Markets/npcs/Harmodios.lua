-----------------------------------
-- Area: Bastok Markets
--  NPC: Harmodios
-- Standard Merchant NPC
-- !pos -79.928 -4.824 -135.114 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        17347,   990, 1,    -- Piccolo
        17344,   219, 2,    -- Cornette
        17353,    43, 2,    -- Maple Harp
        5041,  69120, 2,    -- Scroll of Vital Etude
        5042,  66240, 2,    -- Scroll of Swift Etude
        5043,  63360, 2,    -- Scroll of Sage Etude
        5044,  56700, 2,    -- Scroll of Logical Etude
        5039,  79560, 2,    -- Scroll of Herculean Etude
        5040,  76500, 2,    -- Scroll of Uncanny Etude
        17351,  4644, 3,    -- Gemshorn
        17345,    43, 3,    -- Flute
        5045,  54000, 3,    -- Scroll of Bewitching Etude
    }

    player:showText(npc, ID.text.HARMODIOS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
