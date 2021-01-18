-----------------------------------
-- ID: 4328
-- Item: loaf_of_hobgoblin_bread
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 10
-- Vitality 3
-- Charisma -7
-- Health Regen While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4328)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.CHR, -7)
    target:addMod(tpz.mod.HPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.CHR, -7)
    target:delMod(tpz.mod.HPHEAL, 2)
end

return item_object
