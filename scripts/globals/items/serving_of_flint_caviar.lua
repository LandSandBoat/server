-----------------------------------
-- ID: 4276
-- Item: serving_of_flint_caviar
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 10
-- Magic 10
-- Dexterity 4
-- Mind -1
-- Charisma 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4276)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.CHR, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.CHR, 4)
end

return item_object
