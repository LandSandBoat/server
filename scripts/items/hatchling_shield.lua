-----------------------------------
-- ID: 28652
-- Item: Hatchling Shield
-- When used, you will obtain a random number of egg items
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

local eggTable =
{
    { xi.item.BIRD_EGG,        1,  8, },
    { xi.item.CRAWLER_EGG,     3,  9, },
    { xi.item.EMPEROR_ROE,     1, 10, },
    { xi.item.HARD_BOILED_EGG, 4,  7, },
    { xi.item.LIZARD_EGG,      2,  9, },
    { xi.item.SAIRUI_RAN,      1, 10, },
}

if xi.settings.main.ENABLE_TOAU == 1 then
    table.insert(eggTable, { xi.item.APKALLU_EGG,        1, 11, })
    table.insert(eggTable, { xi.item.CHUNK_OF_FLAN_MEAT, 1,  6, })
    table.insert(eggTable, { xi.item.PUK_EGG,            1,  7, })
    table.insert(eggTable, { xi.item.SALMON_EGGS,        3,  7, })
end

itemObject.onItemUse = function(target)
    local egg = eggTable[math.random(1, #eggTable)]
    target:addItem(egg[1], math.random(egg[2], egg[3]))
end

return itemObject
