-----------------------------------
-- ID: 5637
-- Item: pogaca
-- Food Effect: 5Min, All Races
-----------------------------------
-- Lizard Killer +10
-- Resist Paralyze +10
-- HP Recovered While Healing 4
-- MP Recovered While Healing 4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5637)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.LIZARD_KILLER, 10)
    target:addMod(xi.mod.PARALYZERES, 10)
    target:addMod(xi.mod.HPHEAL, 4)
    target:addMod(xi.mod.MPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.LIZARD_KILLER, 10)
    target:delMod(xi.mod.PARALYZERES, 10)
    target:delMod(xi.mod.HPHEAL, 4)
    target:delMod(xi.mod.MPHEAL, 4)
end

return itemObject
