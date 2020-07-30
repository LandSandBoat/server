-----------------------------------------
-- ID: 5485
-- Beastmaster Die
-- Teaches the job ability Beast Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.BEAST_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.BEAST_ROLL)
end
