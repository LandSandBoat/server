-----------------------------------
--  ID: 26955
--  Behemoth Suit +1
--  When used, player will obtain one of sixteen random meats or with very low
--  chance either a Beastly or Savory Shank. Possible Normal meats are:
--  Buffalo Meat, Cerberus Meat, Cockatrice Meat, Coeurl Meat, Dhalmel Meat,
--  Dragon Meat, Giant Sheep Meat, Hare Meat, Hydra Meat, Karakul Meat,
--  Land Crab Meat, Lucerewe Meat, Lynx Meat, Orobon Meat, Ruszor Meat,
--  Ziz Meat - Data capture 2022-05
--  Chance of obtaining a Beastly or Savory Shank is very low.
--  2/164 Beastly Shank
--  0/164 Savory Shank
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    local meatList =
    {
        { itemId = xi.item.SLICE_OF_BUFFALO_MEAT,     weight =  9 },
        { itemId = xi.item.SLICE_OF_CERBERUS_MEAT,    weight =  4 },
        { itemId = xi.item.SLICE_OF_COCKATRICE_MEAT,  weight = 17 },
        { itemId = xi.item.SLICE_OF_COEURL_MEAT,      weight = 13 },
        { itemId = xi.item.SLICE_OF_DHALMEL_MEAT,     weight = 20 },
        { itemId = xi.item.SLICE_OF_DRAGON_MEAT,      weight =  5 },
        { itemId = xi.item.SLICE_OF_GIANT_SHEEP_MEAT, weight = 17 },
        { itemId = xi.item.SLICE_OF_HARE_MEAT,        weight = 22 },
        { itemId = xi.item.CHUNK_OF_HYDRA_MEAT,       weight =  5 },
        { itemId = xi.item.SLICE_OF_KARAKUL_MEAT,     weight =  4 },
        { itemId = xi.item.SLICE_OF_LAND_CRAB_MEAT,   weight =  9 },
        { itemId = xi.item.SLICE_OF_LUCEREWE_MEAT,    weight =  7 },
        { itemId = xi.item.LYNX_MEAT,                 weight =  5 },
        { itemId = xi.item.CHUNK_OF_OROBON_MEAT,      weight =  9 },
        { itemId = xi.item.SLAB_OF_RUSZOR_MEAT,       weight =  9 },
        { itemId = xi.item.SLICE_OF_ZIZ_MEAT,         weight =  7 },
        { itemId = xi.item.BEASTLY_SHANK,             weight =  2 },
        -- { ?, xi.item.SAVORY_SHANK },
    }

    npcUtil.giveItem(target, { { xi.itemUtils.pickItemRandom(meatList), 1 } })
end

return itemObject
