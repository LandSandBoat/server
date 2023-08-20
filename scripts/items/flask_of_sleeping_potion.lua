-----------------------------------
-- ID: 4161
-- Item: Sleeping Potion
-- Item Effect: This potion induces sleep.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, 30)
end

return itemObject
