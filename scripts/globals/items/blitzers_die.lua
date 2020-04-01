-----------------------------------------
-- ID: 5500
-- Blitzer's Die
-- Teaches the job ability Blitzers Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(105)
end

function onItemUse(target)
    target:addLearnedAbility(105)
end
