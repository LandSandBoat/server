-----------------------------------------
-- ID: 5495
-- Dancer Die
-- Teaches the job ability Dancer's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.DANCERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.DANCERS_ROLL)
end
