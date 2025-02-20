-----------------------------------
-- Area: Windurst Woods
--  NPC: Quesse
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        845,   1150,  1, -- Black Chocobo Feather
        17307, 9,     2, -- Dart
        4545,  62,    3, -- Gysahl Greens
        840,   7,     3, -- Chocobo Feather
        17016, 11,    3, -- Pet Food Alpha Biscuit
        17017, 82,    3, -- Pet Food Beta Biscuit
        17860, 82,    3, -- Carrot Broth
        17862, 695,   3, -- Bug Broth
        17864, 126,   3, -- Herbal Broth
        17866, 695,   3, -- Carrion Broth
        5073,  50784, 3, -- Scroll of Chocobo Mazurka
    }

    player:showText(npc, ID.text.QUESSE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
