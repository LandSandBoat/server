-----------------------------------------
-- ID: 5088
-- Scroll of Gain-DEX
-- Teaches the white magic Gain-DEX
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(487)
end

function onItemUse(target)
    target:addSpell(487)
end
