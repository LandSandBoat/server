-----------------------------------
-- ID: 5171
-- Item: emerald_quiche
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 15
-- Agility 1
-- Ranged ACC % 7
-- Ranged ACC Cap 20
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5171)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.FOOD_RACCP, 7)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 20)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.FOOD_RACCP, 7)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 20)
end

return item_object
