-----------------------------------
-- ID: 28652
-- Item: Hatchling Shield
-- When used, you will obtain a random number of egg items
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

local eggTable =
{
    { xi.items.BIRD_EGG,        1,  8, },
    { xi.items.CRAWLER_EGG,     3,  9, },
    { xi.items.EMPEROR_ROE,     1, 10, },
    { xi.items.HARD_BOILED_EGG, 4,  7, },
    { xi.items.LIZARD_EGG,      2,  9, },
    { xi.items.SAIRUI_RAN,      1, 10, },
}

if xi.settings.main.ENABLE_TOAU == 1 then
    table.insert(eggTable, { xi.items.APKALLU_EGG,        1, 11, })
    table.insert(eggTable, { xi.items.CHUNK_OF_FLAN_MEAT, 1,  6, })
    table.insert(eggTable, { xi.items.PUK_EGG,            1,  7, })
    table.insert(eggTable, { xi.items.SALMON_EGGS,        3,  7, })
end

itemObject.onItemUse = function(target)
    local egg = eggTable[math.random(1, #eggTable)]
    target:addItem(egg[1], math.random(egg[2], egg[3]))
end

return itemObject
