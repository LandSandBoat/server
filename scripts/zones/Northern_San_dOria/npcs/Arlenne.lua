-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arlenne
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
        17024,    72, 3,    -- Ash Club
		17049,    52, 3,    -- Maple Wand
		17050,   370, 3,    -- Willow Wand
		17051,  1566, 1,    -- Yew Wand
		17088,    64, 3,    -- Ash Staff
		17089,   635, 3,    -- Holly Staff
        17090,  3606, 1,    -- Elm Staff
		17095,   420, 3,    -- Ash Pole
		17096,  5076, 2,    -- Holly Pole
        17097, 18240, 1,    -- Elm Pole
		16385,   144, 3,    -- Cesti
		16391,   900, 3,    -- Brass Knuckles
		16407,  1690, 3,    -- Brass Baghnakhs
		16768,   344, 3,    -- Bronze Zaghnal
		16769,  2825, 3,    -- Brass Zaghnal
        16770, 12540, 1,    -- Zaghnal
    }

    player:showText(npc, ID.text.ARLENNE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
