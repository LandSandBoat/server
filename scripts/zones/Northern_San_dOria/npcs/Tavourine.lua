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
        16465,   164, 3,    -- Bronze Knife
		16466,  2425, 3,    -- Knife
		17059,   100, 3,    -- Bronze Rod
		17081,   690, 3,    -- Brass Rod
        17060,  2652, 1,    -- Rod
		17034,   188, 3,    -- Bronze Mace
        17035,  4848, 2,    -- Mace
        16640,   316, 3,    -- Bronze Axe
        16583,  2720, 3,    -- Claymore
		16584, 42000, 1,    -- Mythril Claymore
		16833,   880, 3,    -- Bronze Spear
		16834,  5200, 3,    -- Brass Spear
		16835, 17640, 3,    -- Spear
		16845, 18420, 3,    -- Lance
    }

    player:showText(npc, ID.text.TAVOURINE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
