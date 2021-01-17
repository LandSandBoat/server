-----------------------------------------
-- ID: 4337
-- Item: bowl_of_stamina_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- HP +12% (cap 200)
-- Dexterity 4
-- Vitality 6
-- Mind -3
-- HP Recovered While Healing 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4337)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 12)
    target:addMod(tpz.mod.FOOD_HP_CAP, 200)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.HPHEAL, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 12)
    target:delMod(tpz.mod.FOOD_HP_CAP, 200)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.HPHEAL, 10)
end

return item_object
