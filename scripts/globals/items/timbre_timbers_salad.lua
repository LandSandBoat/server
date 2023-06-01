-----------------------------------
-- ID: 4321
-- Item: timbre_timbers_salad
-- Food Effect: 240Min, All Races
-----------------------------------
-- Magic 20
-- Agility 5
-- Vitality -1
-- Ranged ACC % 8
-- Ranged ACC Cap 15
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4321)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.FOOD_RACCP, 8)
    target:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.FOOD_RACCP, 8)
    target:delMod(xi.mod.FOOD_RACC_CAP, 15)
end

return itemObject
