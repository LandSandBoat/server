-----------------------------------------
-- ID: 15462
-- Item: Sagacious Brocade Obi
-- Effect: 10Min, INT +10
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 600, 15462)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 10)
end

return item_object
