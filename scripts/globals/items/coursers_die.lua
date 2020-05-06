-----------------------------------------
-- ID: 104
-- Courser's Die
-- Teaches the job ability Coursers Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(104)
end

function onItemUse(target)
    target:addLearnedAbility(104)
end
