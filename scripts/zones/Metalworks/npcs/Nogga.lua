-----------------------------------
-- Area: Metalworks
--  NPC: Nogga
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        8918,   579, 1,    -- Soot
        17316,  675, 2,    -- Bomb Arm
        17313, 1083, 3,    -- Grenade
        2792,    92, 3,    -- Catalytic Oil
    }

    player:showText(npc, ID.text.NOGGA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
