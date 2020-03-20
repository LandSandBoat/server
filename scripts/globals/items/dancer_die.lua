-----------------------------------------
-- ID: 5495
-- Dancer Die
-- Teaches the job ability Dancer's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(100)
end

function onItemUse(target)
    target:addLearnedAbility(100)
end
