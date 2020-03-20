-----------------------------------------
-- ID: 5483
-- Paladin Die
-- Teaches the job ability Gallant's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(88)
end

function onItemUse(target)
    target:addLearnedAbility(88)
end
