-----------------------------------------
-- ID: 6369
-- Rune Fencer Die
-- Teaches the job ability Runeist's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(375)
end

function onItemUse(target)
    target:addLearnedAbility(375)
end
