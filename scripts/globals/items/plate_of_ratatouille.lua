-----------------------------------
-- ID: 5731
-- Item: plate_of_ratatouille
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Agility 5
-- Evasion 5
-- HP recovered while healing 2
-- MP recovered while healing 2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5731)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.EVA, 5)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.UNDEAD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.EVA, 5)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.UNDEAD_KILLER, 5)
end

return itemObject
