-----------------------------------------
-- ID: 5482
-- Thief Die
-- Teaches the job ability Rogue's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(87)
end

function onItemUse(target)
    target:addLearnedAbility(87)
end
