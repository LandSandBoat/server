-----------------------------------------
-- ID: 5505
-- Avenger's Die
-- Teaches the job ability Avengers Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(289)
end

function onItemUse(target)
    target:addLearnedAbility(289)
end
