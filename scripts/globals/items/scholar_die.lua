-----------------------------------------
-- ID: 5496
-- Scholar Die
-- Teaches the job ability Scholars Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(101)
end

function onItemUse(target)
    target:addLearnedAbility(101)
end
