-----------------------------------------
-- ID: 5621
-- Item: Candy Ring
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- Dexterity 4
-- Agility 4
-- Charisma 4
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5621)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.CHR, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.CHR, 4)
end

return item_object
