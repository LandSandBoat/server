-----------------------------------------
-- ID: 6461
-- Item: bowl_of_miso_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- HP +105
-- STR +6
-- VIT +6
-- DEF +11% (cap 175)
-- Magic Evasion +11% (cap 55)
-- Magic Def. Bonus +6
-- Resist Slow +15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6461)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 105)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.FOOD_DEFP, 11)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 175)
    -- target:addMod(tpz.mod.FOOD_MEVAP, 11)
    -- target:addMod(tpz.mod.FOOD_MEVA_CAP, 55)
    target:addMod(tpz.mod.MDEF, 6)
    target:addMod(tpz.mod.SLOWRES, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 105)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.FOOD_DEFP, 11)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 175)
    -- target:delMod(tpz.mod.FOOD_MEVAP, 11)
    -- target:delMod(tpz.mod.FOOD_MEVA_CAP, 55)
    target:delMod(tpz.mod.MDEF, 6)
    target:delMod(tpz.mod.SLOWRES, 15)
end

return item_object
