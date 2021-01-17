-----------------------------------------
-- ID: 5217
-- Item: serving_of_salmon_eggs
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Health 6
-- Magic 6
-- Dexterity 2
-- Mind -3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5217)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 6)
    target:addMod(tpz.mod.MP, 6)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.MND, -3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 6)
    target:delMod(tpz.mod.MP, 6)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.MND, -3)
end

return item_object
