-----------------------------------
-- ID: 6188
-- Item: Piece of She-Slime Candy
-- Food Effect: Costume She-Slime
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 0, 0, 10000, 6188)
end

itemObject.onEffectGain = function(target, effect)
    target:setCostume(2438)
end

itemObject.onEffectLose = function(target, effect)
    target:setCostume(0)
end

return itemObject
