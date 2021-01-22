-----------------------------------
-- ID: 5173
-- Item: timbre_timbers_taco
-- Food Effect: 1hour, All Races
-----------------------------------
-- MP 20
-- Vitality -1
-- Agility 5
-- MP Recovered While Healing 3
-- Ranged Accuracy % 8 (cap 15)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5173)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.MPHEAL, 3)
    target:addMod(tpz.mod.FOOD_RACCP, 8)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.MPHEAL, 3)
    target:delMod(tpz.mod.FOOD_RACCP, 8)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 15)
end

return item_object
