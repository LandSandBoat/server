-----------------------------------
-- ID: 5923
-- Item: Juglan Jumble
-- Food Effect: 5 Min, All Races
-----------------------------------
-- HP Healing 5
-- MP Healing 8
-- Bird Killer 12
-- Resist Paralyze 12
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5923)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 5)
    target:addMod(xi.mod.MPHEAL, 8)
    target:addMod(xi.mod.BIRD_KILLER, 12)
    target:addMod(xi.mod.PARALYZERES, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 5)
    target:delMod(xi.mod.MPHEAL, 8)
    target:delMod(xi.mod.BIRD_KILLER, 12)
    target:delMod(xi.mod.PARALYZERES, 12)
end

return itemObject
