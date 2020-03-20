-----------------------------------------
-- ID: 5497
-- Bolter's Die
-- Teaches the job ability Bolters Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(102)
end

function onItemUse(target)
    target:addLearnedAbility(102)
end
