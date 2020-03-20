-----------------------------------------
-- ID: 5504
-- Companions Die
-- Teaches the job ability Companions Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(288)
end

function onItemUse(target)
    target:addLearnedAbility(288)
end
