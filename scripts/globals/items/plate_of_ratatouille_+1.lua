-----------------------------------------
-- ID: 5732
-- Item: plate_of_ratatouille_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- Agility 6
-- Evasion 10
-- HP recovered while healing 3
-- MP recovered while healing 3
-- Undead Killer 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5732)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, 6)
    target:addMod(tpz.mod.EVA, 10)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 3)
    target:addMod(tpz.mod.UNDEAD_KILLER, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, 6)
    target:delMod(tpz.mod.EVA, 10)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 3)
    target:delMod(tpz.mod.UNDEAD_KILLER, 10)
end

return item_object
