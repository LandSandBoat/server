-----------------------------------
-- ID: 4275
-- Item: serving_of_emperor_roe
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 8
-- Magic 8
-- Dexterity 4
-- Mind -4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4275)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.MP, 8)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.MND, -4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.MP, 8)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.MND, -4)
end

return item_object
