-----------------------------------------
-- ID: 4487
-- Item: colored_egg
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 20
-- Magic 20
-- Attack 3
-- Ranged Attack 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4487)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.ATT, 3)
    target:addMod(tpz.mod.RATT, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.ATT, 3)
    target:delMod(tpz.mod.RATT, 2)
end

return item_object
