-----------------------------------
-- Area: Metalworks
--  NPC: Olaf
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        17248, 46836, 2,    -- Arquebus
        17340,    90, 3,    -- Bullet
          928,   463, 3,    -- Bomb Ash
    }

    player:showText(npc, ID.text.OLAF_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
