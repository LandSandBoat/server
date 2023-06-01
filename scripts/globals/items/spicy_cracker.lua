-----------------------------------
-- ID: 4466
-- Item: spicy_cracker
-- Food Effect: 3Min, All Races
-----------------------------------
-- HP Recovered While Healing 7
-- Beast Killer +10
-- Resist Sleep +10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 4466)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 7)
    target:addMod(xi.mod.BEAST_KILLER, 10)
    target:addMod(xi.mod.SLEEPRES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 7)
    target:delMod(xi.mod.BEAST_KILLER, 10)
    target:delMod(xi.mod.SLEEPRES, 10)
end

return itemObject
