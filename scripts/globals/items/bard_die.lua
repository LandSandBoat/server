-----------------------------------------
-- ID: 5486
-- Bard Die
-- Teaches the job ability Choral Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.CHORAL_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.CHORAL_ROLL)
end
