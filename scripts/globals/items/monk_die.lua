-----------------------------------------
-- ID: 5478
-- Monk Die
-- Teaches the job ability Monk's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.MONKS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.MONKS_ROLL)
end
