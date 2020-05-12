-----------------------------------------
-- ID: 5092
-- Scroll of Gain-MND
-- Teaches the white magic Gain-MND
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(491)
end

function onItemUse(target)
    target:addSpell(491)
end
