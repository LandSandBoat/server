-----------------------------------
-- ID: 6369
-- Rune Fencer Die
-- Teaches the job ability Runeist's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.RUNEISTS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.RUNEISTS_ROLL)
end

return item_object
