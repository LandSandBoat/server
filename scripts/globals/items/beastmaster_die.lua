-----------------------------------------
-- ID: 5485
-- Beastmaster Die
-- Teaches the job ability Beast Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(90)
end

function onItemUse(target)
    target:addLearnedAbility(90)
end
