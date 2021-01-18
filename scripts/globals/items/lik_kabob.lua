-----------------------------------
-- ID: 5647
-- Item: Lik Kabob
-- Food Effect: 30 Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -2
-- Accuracy +1
-- Attack 7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5647)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.ACC, 1)
    target:addMod(tpz.mod.ATT, 7)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.ACC, 1)
    target:delMod(tpz.mod.ATT, 7)
end

return item_object
