-----------------------------------
-- ID: 4286
-- Item: cup_of_healing_tea
-- Food Effect: 240Min, All Races
-----------------------------------
-- Magic 10
-- Vitality -1
-- Charisma 3
-- Magic Regen While Healing 2
-- Sleep resistance -40
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4286)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.CHR, 3)
    target:addMod(xi.mod.MPHEAL, 2)
    target:addMod(xi.mod.SLEEPRES, -40)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.CHR, 3)
    target:delMod(xi.mod.MPHEAL, 2)
    target:delMod(xi.mod.SLEEPRES, -40)
end

return itemObject
