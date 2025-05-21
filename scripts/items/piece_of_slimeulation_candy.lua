-----------------------------------
-- ID: 6187
-- Item: Piece of Slimeulation Candy
-- Food Effect: Costume Slime
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 0, 0, 10000, 6187)
end

itemObject.onEffectGain = function(target, effect)
    target:setCostume(2881)
end

itemObject.onEffectLose = function(target, effect)
    target:setCostume(0)
end

return itemObject
