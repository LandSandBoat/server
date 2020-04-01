-----------------------------------------
-- ID: 5489
-- Ninja Die
-- Teaches the job ability Ninja Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(94)
end

function onItemUse(target)
    target:addLearnedAbility(94)
end
