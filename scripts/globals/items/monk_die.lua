-----------------------------------------
-- ID: 5478
-- Monk Die
-- Teaches the job ability Monk's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(83)
end

function onItemUse(target)
    target:addLearnedAbility(83)
end
