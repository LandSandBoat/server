-----------------------------------------
-- ID: 5094
-- Scroll of Boost-STR
-- Teaches the white magic Boost-STR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(479)
end

function onItemUse(target)
    target:addSpell(479)
end
