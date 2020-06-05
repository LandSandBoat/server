-----------------------------------------
-- ID: 5480
-- Black Mage Die
-- Teaches the job ability Wizard's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(85)
end

function onItemUse(target)
    target:addLearnedAbility(85)
end
