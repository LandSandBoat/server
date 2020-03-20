-----------------------------------------
-- ID: 5090
-- Scroll of Gain-AGI
-- Teaches the white magic Gain-AGI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(489)
end

function onItemUse(target)
    target:addSpell(489)
end
