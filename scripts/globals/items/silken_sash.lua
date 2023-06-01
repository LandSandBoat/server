-----------------------------------
-- ID: 5632
-- Item: Silken Sash
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP Recovered while healing +3
-- MP Recovered while healing +6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5632)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 3)
    target:addMod(xi.mod.MPHEAL, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 3)
    target:delMod(xi.mod.MPHEAL, 6)
end

return itemObject
