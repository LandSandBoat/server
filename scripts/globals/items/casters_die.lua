-----------------------------------------
-- ID: 5498
-- Casters Die
-- Teaches the job ability Casters Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(103)
end

function onItemUse(target)
    target:addLearnedAbility(103)
end
