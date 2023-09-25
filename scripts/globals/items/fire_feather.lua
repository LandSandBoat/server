-----------------------------------
-- ID: 5256
-- Item: Fire Feather
-- Status Effect: Enfire
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENFIRE, 10, 0, 180) -- This is a guess, no potency or duration info is known
end

return itemObject
