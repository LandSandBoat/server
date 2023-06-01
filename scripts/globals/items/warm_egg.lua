-----------------------------------
-- ID: 4602
-- Item: warm_egg
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health 18
-- Magic 18
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4602)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.MP, 18)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.MP, 18)
end

return itemObject
