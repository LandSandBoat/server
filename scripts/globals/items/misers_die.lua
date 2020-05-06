-----------------------------------------
-- ID: 5503
-- Miser's Die
-- Teaches the job ability Miser's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(287)
end

function onItemUse(target)
    target:addLearnedAbility(287)
end
