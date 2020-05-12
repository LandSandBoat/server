-----------------------------------------
-- ID: 5492
-- Blue Mage Die
-- Teaches the job ability Magus's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(97)
end

function onItemUse(target)
    target:addLearnedAbility(97)
end
