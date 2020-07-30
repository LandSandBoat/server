-----------------------------------------
-- ID: 5493
-- Corsair Die
-- Teaches the job ability Corsair's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.CORSAIRS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.CORSAIRS_ROLL)
end
