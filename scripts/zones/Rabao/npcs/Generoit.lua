-----------------------------------
-- Area: Rabao
--  NPC: Generoit
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4545,    61,    -- Gysahl Greens
        840,      7,    -- Chocobo Feather
        17016,   10,    -- Pet Food Alpha Biscuit
        17017,   81,    -- Pet Food Beta Biscuit
        17860,   81,    -- Carrot Broth
        17862,  687,    -- Bug Broth
        17864,  125,    -- Herbal Broth
        17866,  687,    -- Carrion Broth
        5073, 50784,    -- Scroll of Chocobo Mazurka
    }

    player:showText(npc, ID.text.GENEROIT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
