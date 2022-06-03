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
require("scripts/globals/msg")
require("scripts/globals/items")
require("scripts/globals/item_utils")
require("scripts/globals/npc_util")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    local meatList =
    {
        { 9, xi.items.SLICE_OF_BUFFALO_MEAT}, -- 5152
        { 4, xi.items.SLICE_OF_CERBERUS_MEAT}, -- 5565
        {17, xi.items.SLICE_OF_COCKATRICE_MEAT}, -- 4435
        {13, xi.items.SLICE_OF_COEURL_MEAT}, -- 4377
        {20, xi.items.DHALMEL_MEAT}, -- 4359
        { 5, xi.items.SLICE_OF_DRAGON_MEAT}, -- 4272
        {17, xi.items.SLICE_OF_GIANT_SHEEP_MEAT}, -- 4372
        {22, xi.items.SLICE_OF_HARE_MEAT}, -- 4358
        { 5, xi.items.CHUNK_OF_HYDRA_MEAT}, -- 5564
        { 4, xi.items.SLICE_OF_KARAKUL_MEAT}, -- 5571
        { 9, xi.items.LAND_CRAB_MEAT}, -- 4400
        { 7, xi.items.SLICE_OF_LUCEREWE_MEAT}, -- 5531
        { 5, xi.items.LYNX_MEAT}, --5667
        { 9, xi.items.CHUNK_OF_OROBON_MEAT}, -- 5563
        { 9, xi.items.SLAB_OF_RUSZOR_MEAT}, -- 5755
        { 7, xi.items.SLICE_OF_ZIZ_MEAT}, -- 5581
        { 2, xi.items.BEASTLY_SHANK}, -- 3341
        -- { ?, xi.items.SAVORY_SHANK}, -- 3342
    }
    npcUtil.giveItem(target, { { xi.item_utils.pickItemRandom(target, meatList), 1 } })
end

return item_object
