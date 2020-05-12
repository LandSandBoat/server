-----------------------------------------
-- ID: 4884
-- Scroll of Blind II
-- Teaches the black magic Blind II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(276)
end

function onItemUse(target)
    target:addSpell(276)
end
