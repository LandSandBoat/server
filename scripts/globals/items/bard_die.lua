-----------------------------------------
-- ID: 5486
-- Bard Die
-- Teaches the job ability Choral Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(91)
end

function onItemUse(target)
    target:addLearnedAbility(91)
end
