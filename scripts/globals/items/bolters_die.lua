-----------------------------------------
-- ID: 5497
-- Bolter's Die
-- Teaches the job ability Bolters Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.BOLTERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.BOLTERS_ROLL)
end
