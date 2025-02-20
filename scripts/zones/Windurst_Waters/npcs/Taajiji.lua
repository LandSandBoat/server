-----------------------------------
-- Area: Windurst Waters
--  NPC: Taajiji
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.TAAJIJI_SHOP_DIALOG)

    local stock =
    {
        4411,   756, 1, -- Dhalmel Pie
        4434,  5050, 1, -- Mushroom Risotto
        4554, 12762, 1, -- Shallops Tropicale
        4393,   984, 1, -- Orange Kuchen
        4506,  5216, 2, -- Mutton Tortilla
        4440,  6064, 2, -- Whitefish Stew
        4572,  1669, 2, -- Beaugreen Saute
        4422,   184, 2, -- Orange Juice
        4438,  1324, 2, -- Dhalmel Steak
        4408,   128, 3, -- Tortilla
        4492,   552, 3, -- Puls
        4433,  2387, 3, -- Dhalmel Stew
        4509,    10, 3, -- Distilled Water
        4493,   184, 3, -- Windurstian Tea
        4555,  1711, 3, -- Windurst Salad
    }

    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
