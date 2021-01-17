-----------------------------------------
-- ID: 5731
-- Item: plate_of_ratatouille
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- Agility 5
-- Evasion 5
-- HP recovered while healing 2
-- MP recovered while healing 2
-- Undead Killer 5
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5731)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.UNDEAD_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.UNDEAD_KILLER, 5)
end

return item_object
