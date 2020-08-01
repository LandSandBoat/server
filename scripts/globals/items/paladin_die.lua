-----------------------------------------
-- ID: 5483
-- Paladin Die
-- Teaches the job ability Gallant's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.GALLANTS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.GALLANTS_ROLL)
end
