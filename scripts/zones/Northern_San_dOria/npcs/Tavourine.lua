-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Tavourine
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        16584, 37800, 1,    -- Mythril Claymore
        16466,  2182, 1,    -- Knife
        17060,  2386, 1,    -- Rod
        16640,   284, 2,    -- Bronze Axe
        16465,   147, 2,    -- Bronze Knife
        17081,   621, 2,    -- Brass Rod
        16583,  2448, 2,    -- Claymore
        17035,  4363, 2,    -- Mace
        17059,    90, 3,    -- Bronze Rod
        17034,   169, 3,    -- Bronze Mace
        16845, 16578, 3,    -- Lance
    }

    player:showText(npc, ID.text.TAVOURINE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
