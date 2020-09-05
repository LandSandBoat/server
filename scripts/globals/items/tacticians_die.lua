-----------------------------------------
-- ID: 5501
-- Tactician's Die
-- Teaches the job ability Tactician's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.TACTICIANS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.TACTICIANS_ROLL)
end
