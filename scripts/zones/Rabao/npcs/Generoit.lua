-----------------------------------
-- Area: Rabao
--  NPC: Generoit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_GYSAHL_GREENS,       70 },
        { xi.item.CHOCOBO_FEATHER,               8 },
        { xi.item.PET_FOOD_ALPHA_BISCUIT,       12 },
        { xi.item.PET_FOOD_BETA_BISCUIT,        93 },
        { xi.item.JUG_OF_CARROT_BROTH,          62 },
        { xi.item.JUG_OF_BUG_BROTH,            101 },
        { xi.item.JUG_OF_HERBAL_BROTH,         112 },
        { xi.item.JUG_OF_CARRION_BROTH,        313 },
        { xi.item.SCROLL_OF_CHOCOBO_MAZURKA, 57408 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.GENEROIT_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
