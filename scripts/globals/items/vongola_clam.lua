-----------------------------------
-- ID: 5131
-- Item: Vongola Clam
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -5
-- Vitality 4
-- Defense +17% - 50 Cap
-- HP 5% - 50 Cap
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getRace() ~= xi.race.MITHRA then
        result = xi.msg.basic.CANNOT_EAT
    end

    if target:getMod(xi.mod.EAT_RAW_FISH) == 1 then
        result = 0
    end

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5131)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, -5)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_DEFP, 17)
    target:addMod(xi.mod.FOOD_DEF_CAP, 50)
    target:addMod(xi.mod.FOOD_HPP, 5)
    target:addMod(xi.mod.FOOD_HP_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, -5)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_DEFP, 17)
    target:delMod(xi.mod.FOOD_DEF_CAP, 50)
    target:delMod(xi.mod.FOOD_HPP, 5)
    target:delMod(xi.mod.FOOD_HP_CAP, 50)
end

return itemObject
