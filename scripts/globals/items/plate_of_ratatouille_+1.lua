-----------------------------------
-- ID: 5732
-- Item: plate_of_ratatouille_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Agility 6
-- Evasion 10
-- HP recovered while healing 3
-- MP recovered while healing 3
-- Undead Killer 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5732)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 6)
    target:addMod(xi.mod.EVA, 10)
    target:addMod(xi.mod.HPHEAL, 3)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.UNDEAD_KILLER, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 6)
    target:delMod(xi.mod.EVA, 10)
    target:delMod(xi.mod.HPHEAL, 3)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.UNDEAD_KILLER, 10)
end

return item_object
