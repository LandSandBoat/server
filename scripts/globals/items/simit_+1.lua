-----------------------------------
-- ID: 5597
-- Item: simit_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 18
-- Vitality 4
-- Defense 2
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5597)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.DEF, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.DEF, 2)
end

return itemObject
