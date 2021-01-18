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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4543)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MND, 10)
    target:addMod(tpz.mod.CHR, -5)
    target:addMod(tpz.mod.POISONRES, 4)
    target:addMod(tpz.mod.BLINDRES, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MND, 10)
    target:delMod(tpz.mod.CHR, -5)
    target:delMod(tpz.mod.POISONRES, 4)
    target:delMod(tpz.mod.BLINDRES, 4)
end

return item_object
