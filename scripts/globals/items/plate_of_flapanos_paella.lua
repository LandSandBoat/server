-----------------------------------
-- ID: 5975
-- Item: Plate of Flapano's Paella
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- HP 45
-- Vitality 6
-- Defense % 26 Cap 155
-- Undead Killer 6
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5975)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 45)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.FOOD_DEFP, 26)
    target:addMod(xi.mod.FOOD_DEF_CAP, 155)
    target:addMod(xi.mod.UNDEAD_KILLER, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 45)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.FOOD_DEFP, 26)
    target:delMod(xi.mod.FOOD_DEF_CAP, 155)
    target:delMod(xi.mod.UNDEAD_KILLER, 6)
end

return item_object
