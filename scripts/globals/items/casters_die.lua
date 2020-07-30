-----------------------------------------
-- ID: 5498
-- Casters Die
-- Teaches the job ability Casters Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.CASTERS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.CASTERS_ROLL)
end
