-----------------------------------
-- ID: 5934
-- Item: Chocobiscuit
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 3
-- Charisma 3
-- Evasion 2
-- Aquan Killer 10
-- Silence Resist 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5934)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MPHEAL, 3)
    target:addMod(tpz.mod.CHR, 3)
    target:addMod(tpz.mod.EVA, 2)
    target:addMod(tpz.mod.AQUAN_KILLER, 10)
    target:addMod(tpz.mod.SILENCERES, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MPHEAL, 3)
    target:delMod(tpz.mod.CHR, 3)
    target:delMod(tpz.mod.EVA, 2)
    target:delMod(tpz.mod.AQUAN_KILLER, 10)
    target:delMod(tpz.mod.SILENCERES, 10)
end

return item_object
