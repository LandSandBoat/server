-----------------------------------------
-- ID: 5501
-- Tactician's Die
-- Teaches the job ability Tactician's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(106)
end

function onItemUse(target)
    target:addLearnedAbility(106)
end
