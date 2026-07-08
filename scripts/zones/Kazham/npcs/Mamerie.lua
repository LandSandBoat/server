-----------------------------------
-- Area: Kazham
--  NPC: Mamerie
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,       71 },
        { xi.item.CHOCOBO_FEATHER,               8 },
        { xi.item.PET_FOOD_ALPHA_BISCUIT,       12 },
        { xi.item.PET_FOOD_BETA_BISCUIT,        94 },
        { xi.item.JUG_OF_CARROT_BROTH,          63 },
        { xi.item.JUG_OF_BUG_BROTH,            102 },
        { xi.item.JUG_OF_HERBAL_BROTH,         113 },
        { xi.item.JUG_OF_CARRION_BROTH,        316 },
        { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 57960 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.MAMERIE_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
