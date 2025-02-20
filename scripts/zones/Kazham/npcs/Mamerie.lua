-----------------------------------
-- Area: Kazham
--  NPC: Mamerie
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4545,    62,    -- Gysahl Greens
        840,      7,    -- Chocobo Feather
        17016,   11,    -- Pet Food Alpha Biscuit
        17017,   82,    -- Pet Food Beta Biscuit
        17860,   82,    -- Carrot Broth
        17862,  695,    -- Bug Broth
        17864,  126,    -- Herbal Broth
        17866,  695,    -- Carrion Broth
        5073, 50784,    -- Scroll of Chocobo Mazurka
    }

    player:showText(npc, ID.text.MAMERIE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
