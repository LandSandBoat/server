-----------------------------------------
-- ID: 5099
-- Scroll of Boost-MND
-- Teaches the white magic Boost-MND
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(484)
end

function onItemUse(target)
    target:addSpell(484)
end
