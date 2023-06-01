-----------------------------------
-- ID: 4292
-- Item: loaf_of_pain_de_neige
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 18
-- Vitality 4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4292)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.VIT, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.VIT, 4)
end

return itemObject
