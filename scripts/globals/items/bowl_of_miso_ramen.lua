-----------------------------------
-- ID: 6460
-- Item: bowl_of_miso_ramen
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +100
-- STR +5
-- VIT +5
-- DEF +10% (cap 170)
-- Magic Evasion +10% (cap 50)
-- Magic Def. Bonus +5
-- Resist Slow +10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6460)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 100)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.FOOD_DEFP, 10)
    target:addMod(xi.mod.FOOD_DEF_CAP, 170)
    -- target:addMod(xi.mod.FOOD_MEVAP, 10)
    -- target:addMod(xi.mod.FOOD_MEVA_CAP, 50)
    target:addMod(xi.mod.MDEF, 5)
    target:addMod(xi.mod.SLOWRES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 100)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.FOOD_DEFP, 10)
    target:delMod(xi.mod.FOOD_DEF_CAP, 170)
    -- target:delMod(xi.mod.FOOD_MEVAP, 10)
    -- target:delMod(xi.mod.FOOD_MEVA_CAP, 50)
    target:delMod(xi.mod.MDEF, 5)
    target:delMod(xi.mod.SLOWRES, 10)
end

return itemObject
