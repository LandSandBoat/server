-----------------------------------------
-- ID: 5487
-- Ranger Die
-- Teaches the job ability Hunter's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(92)
end

function onItemUse(target)
    target:addLearnedAbility(92)
end
