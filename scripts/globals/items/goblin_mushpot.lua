-----------------------------------
-- ID: 4543
-- Item: goblin_mushpot
-- Food Effect: 180Min, All Races
-----------------------------------
-- Mind 10
-- Charisma -5
-- Poison Resist 4
-- Blind Resist 4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4543)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, 10)
    target:addMod(xi.mod.CHR, -5)
    target:addMod(xi.mod.POISONRES, 4)
    target:addMod(xi.mod.BLINDRES, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MND, 10)
    target:delMod(xi.mod.CHR, -5)
    target:delMod(xi.mod.POISONRES, 4)
    target:delMod(xi.mod.BLINDRES, 4)
end

return itemObject
