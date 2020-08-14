-----------------------------------------
-- ID: 4694
-- Scroll of Barsleepra
-- Teaches the white magic Barsleepra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(86)
end

function onItemUse(target)
    target:addSpell(86)
end
