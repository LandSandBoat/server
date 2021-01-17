-----------------------------------------
-- ID: 4452
-- Item: bowl_of_shark_fin_soup
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP % 5 (cap 150)
-- MP 5
-- Dexterity 4
-- HP Recovered While Healing 9
-- Attack % 14 (cap 85)
-- Ranged Attack % 14 (cap 85)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4452)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 5)
    target:addMod(tpz.mod.FOOD_HP_CAP, 150)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.MP, 5)
    target:addMod(tpz.mod.HPHEAL, 9)
    target:addMod(tpz.mod.FOOD_ATTP, 14)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:addMod(tpz.mod.FOOD_RATTP, 14)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 85)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 5)
    target:delMod(tpz.mod.FOOD_HP_CAP, 150)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.MP, 5)
    target:delMod(tpz.mod.HPHEAL, 9)
    target:delMod(tpz.mod.FOOD_ATTP, 14)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 85)
    target:delMod(tpz.mod.FOOD_RATTP, 14)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 85)
end

return item_object
