-----------------------------------------
-- ID: 5500
-- Blitzer's Die
-- Teaches the job ability Blitzers Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.BLITZERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.BLITZERS_ROLL)
end
