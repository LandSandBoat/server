-----------------------------------------
-- ID: 5087
-- Scroll of Gain-STR
-- Teaches the white magic Gain-STR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(486)
end

function onItemUse(target)
    target:addSpell(486)
end
