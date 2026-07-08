-----------------------------------
-- ID: 6187
-- Item: Piece of Slimeulation Candy
-- Food Effect: Costume Slime
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.COSTUME, { duration = 10000, origin = user, subType = 6187 })
end

itemObject.onEffectGain = function(target, effect)
    target:setCostume(2881)
end

itemObject.onEffectLose = function(target, effect)
    target:setCostume(0)
end

return itemObject
