-----------------------------------
-- ID: 6369
-- Rune Fencer Die
-- Teaches the job ability Runeist's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.RUNEISTS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.RUNEISTS_ROLL)
end

return itemObject
