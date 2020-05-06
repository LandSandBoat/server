-----------------------------------------
-- ID: 5488
-- Samurai Die
-- Teaches the job ability Samurai Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(93)
end

function onItemUse(target)
    target:addLearnedAbility(93)
end
