-----------------------------------
-- Area: Windurst Waters
--  NPC: Moogle (Vendor variant)
-- Type: Special Events Vendor Moogles
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

local starlight_stock1 =
    {
        4215, 40,      -- Popstar
        4216, 40,      -- Brilliant Snow
        4217, 25,      -- Sparkling Hand
        4218, 100,     -- Air Rider
        4167, 8,       -- Cracker
        4168, 25,      -- Twinkle Shower
        4169, 25,      -- Little Comet
        15178, 500,     -- Dream Hat
        86,   10000,   -- San d'Orian Tree
        115,  10000,   -- Bastokan Tree
        116,  10000,   -- Windurstian Tree
    }

    local starlight_stock2 =
    {
        176, 10000,    -- Snowman Knight
        177, 10000,    -- Snowman Miner
        178, 10000,    -- Snowman Mage
        10875, 5000,    -- Snowman Cap
        6498, 777,     -- Fortune Fruits
        4495, 50       -- Goblin Chocolate
    }

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getID() == 17752561 then
        player:showText(npc, ID.text.STARLIGHT_VENDOR_MOOGLE)
        xi.shop.general(player, starlight_stock1)
    elseif npc:getID() == 17752560 then
        player:showText(npc, ID.text.STARLIGHT_VENDOR_MOOGLE)
        xi.shop.general(player, starlight_stock2)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
