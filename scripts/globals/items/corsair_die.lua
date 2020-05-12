-----------------------------------------
-- ID: 5493
-- Corsair Die
-- Teaches the job ability Corsair's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(98)
end

function onItemUse(target)
    target:addLearnedAbility(98)
end
