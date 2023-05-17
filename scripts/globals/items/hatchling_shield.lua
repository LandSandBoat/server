-----------------------------------
-- ID: 28652
-- Item: Hatchling Shield
-- When used, you will obtain a random number of egg items
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/items")
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

itemObject.onItemUse = function(target)
    local egg = eggTable[math.random(1, #eggTable)]
    target:addItem(egg[1], math.random(egg[2], egg[3]))
end

return itemObject
