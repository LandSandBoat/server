-----------------------------------------
-- ID: 5481
-- Red Mage Die
-- Teaches the job ability Warlock's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(86)
end

function onItemUse(target)
    target:addLearnedAbility(86)
end
