-----------------------------------------
-- ID: 5490
-- Dragoon Die
-- Teaches the job ability Drachen Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.DRACHEN_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.DRACHEN_ROLL)
end
