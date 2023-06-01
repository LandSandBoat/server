-----------------------------------
-- ID: 5594
-- Item: cup_of_chai_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- Vitality -3
-- Charisma 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5594)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -3)
    target:addMod(xi.mod.CHR, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -3)
    target:delMod(xi.mod.CHR, 3)
end

return itemObject
