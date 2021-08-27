-----------------------------------
-- ID: 6461
-- Item: bowl_of_miso_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +105
-- STR +6
-- VIT +6
-- DEF +11% (cap 175)
-- Magic Evasion +11% (cap 55)
-- Magic Def. Bonus +6
-- Resist Slow +15
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6461)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 105)
    target:addMod(xi.mod.STR, 6)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.FOOD_DEFP, 11)
    target:addMod(xi.mod.FOOD_DEF_CAP, 175)
    -- target:addMod(xi.mod.FOOD_MEVAP, 11)
    -- target:addMod(xi.mod.FOOD_MEVA_CAP, 55)
    target:addMod(xi.mod.MDEF, 6)
    target:addMod(xi.mod.SLOWRES, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 105)
    target:delMod(xi.mod.STR, 6)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.FOOD_DEFP, 11)
    target:delMod(xi.mod.FOOD_DEF_CAP, 175)
    -- target:delMod(xi.mod.FOOD_MEVAP, 11)
    -- target:delMod(xi.mod.FOOD_MEVA_CAP, 55)
    target:delMod(xi.mod.MDEF, 6)
    target:delMod(xi.mod.SLOWRES, 15)
end

return item_object
