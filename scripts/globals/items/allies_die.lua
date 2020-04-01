-----------------------------------------
-- ID: 5502
-- Allies' Die
-- Teaches the job ability Allies Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(286)
end

function onItemUse(target)
    target:addLearnedAbility(286)
end
