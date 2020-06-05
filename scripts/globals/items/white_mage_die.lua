-----------------------------------------
-- ID: 5479
-- White Mage Die
-- Teaches the job ability Healer's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(84)
end

function onItemUse(target)
    target:addLearnedAbility(84)
end
