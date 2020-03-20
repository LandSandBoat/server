-----------------------------------------
-- ID: 5484
-- Dark Knight Die
-- Teaches the job ability Chaos Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(89)
end

function onItemUse(target)
    target:addLearnedAbility(89)
end
