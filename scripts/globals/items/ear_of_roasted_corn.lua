-----------------------------------
-- ID: 4415
-- Item: ear_of_roasted_corn
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 6
-- Dexterity -1
-- Vitality 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4415)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 6)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.VIT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 6)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.VIT, 3)
end

return itemObject
