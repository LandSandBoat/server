-----------------------------------------
-- ID: 5487
-- Ranger Die
-- Teaches the job ability Hunter's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.HUNTERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.HUNTERS_ROLL)
end
