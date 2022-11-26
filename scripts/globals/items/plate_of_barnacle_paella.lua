-----------------------------------
-- ID: 5974
-- Item: Plate of Barnacle Paella
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 40
-- Vitality 5
-- Mind -1
-- Charisma -1
-- Defense % 25 Cap 150
-- Undead Killer 5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5974)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 40)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.CHR, -1)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 150)
    target:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 40)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.CHR, -1)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 150)
    target:delMod(xi.mod.UNDEAD_KILLER, 5)
end

return itemObject
