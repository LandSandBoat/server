-----------------------------------
-- Area: Upper Jeuno
--  NPC: Theraisie
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.JUG_OF_LIVID_BROTH,        200 },
        { xi.item.JUG_OF_LYRICAL_BROTH,      344 },
        { xi.item.JUG_OF_AIRY_BROTH,         591 },
        { xi.item.HANDFUL_OF_CRUMBLY_SOIL,  1016 },
        { xi.item.JUG_OF_FURIOUS_BROTH,     1305 },
        { xi.item.JUG_OF_BLACKWATER_BROTH,  1484 },
        { xi.item.JUG_OF_PALE_SAP,          1747 },
        { xi.item.JUG_OF_CRACKLING_BROTH,   1747 },
        { xi.item.JUG_OF_MEATY_BROTH,       2196 },
        { xi.item.JUG_OF_RAPID_BROTH,       2371 },
        { xi.item.JUG_OF_CREEPY_BROTH,      2425 },
        { xi.item.JUG_OF_MUDDY_BROTH,       2853 },
        { xi.item.JUG_OF_DIRE_BROTH,        3004 },
        { xi.item.JUG_OF_AGED_HUMUS,        3154 },
        { xi.item.PET_FOOD_ALPHA_BISCUIT,    100 },
        { xi.item.PET_FOOD_BETA_BISCUIT,     200 },
        { xi.item.PET_FOOD_GAMMA_BISCUIT,    350 },
        { xi.item.PET_FOOD_DELTA_BISCUIT,    500 },
        { xi.item.PET_FOOD_EPSILON_BISCUIT,  750 },
        { xi.item.PET_FOOD_ZETA_BISCUIT,    1000 },
        { xi.item.PET_FOOD_ETA_BISCUIT,     1500 },
        { xi.item.PET_FOOD_THETA_BISCUIT,   2000 },
        { xi.item.PET_ROBORANT,              300 },
        { xi.item.PET_POULTICE,              250 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.MP_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
