-----------------------------------
-- ID: 4280
-- Item: garlic_cracker_+1
-- Food Effect: 5Min, All Races
-----------------------------------
-- HP recovered while healing +8
-- Undead Killer +12
-- Blind Resist +12
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4280)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 8)
    target:addMod(xi.mod.UNDEAD_KILLER, 12)
    target:addMod(xi.mod.BLINDRES, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 8)
    target:delMod(xi.mod.UNDEAD_KILLER, 12)
    target:delMod(xi.mod.BLINDRES, 12)
end

return itemObject
