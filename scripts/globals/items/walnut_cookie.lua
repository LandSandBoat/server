-----------------------------------
-- ID: 5922
-- Item: Walnut Cookie
-- Food Effect: 3 Min, All Races
-----------------------------------
-- HP Healing 3
-- MP Healing 6
-- Bird Killer 10
-- Resist Paralyze 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5922)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 3)
    target:addMod(xi.mod.MPHEAL, 6)
    target:addMod(xi.mod.BIRD_KILLER, 10)
    target:addMod(xi.mod.PARALYZERES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 3)
    target:delMod(xi.mod.MPHEAL, 6)
    target:delMod(xi.mod.BIRD_KILLER, 10)
    target:delMod(xi.mod.PARALYZERES, 10)
end

return itemObject
