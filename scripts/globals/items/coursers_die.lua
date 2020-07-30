-----------------------------------------
-- ID: 104
-- Courser's Die
-- Teaches the job ability Coursers Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.COURSERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.COURSERS_ROLL)
end
