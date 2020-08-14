-----------------------------------------
-- ID: 5095
-- Scroll of Boost-DEX
-- Teaches the white magic Boost-DEX
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(480)
end

function onItemUse(target)
    target:addSpell(480)
end
