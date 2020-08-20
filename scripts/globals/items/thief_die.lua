-----------------------------------------
-- ID: 5482
-- Thief Die
-- Teaches the job ability Rogue's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.ROGUES_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.ROGUES_ROLL)
end
