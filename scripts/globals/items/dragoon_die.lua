-----------------------------------------
-- ID: 5490
-- Dragoon Die
-- Teaches the job ability Drachen Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(95)
end

function onItemUse(target)
    target:addLearnedAbility(95)
end
