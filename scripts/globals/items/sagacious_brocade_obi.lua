-----------------------------------------
-- ID: 15462
-- Item: Sagacious Brocade Obi
-- Effect: 10Min, INT +10
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 600, 0, 0, 0, xi.items.SAGACIOUS_BROCADE_OBI)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 10)
end

return itemObject
