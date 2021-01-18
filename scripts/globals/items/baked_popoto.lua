-----------------------------------
-- ID: 4436
-- Item: Baked Popoto
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 20
-- Dexterity -1
-- Vitality 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4436)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.VIT, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.VIT, 2)
end

return item_object
