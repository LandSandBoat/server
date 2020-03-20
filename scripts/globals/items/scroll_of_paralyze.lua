-----------------------------------------
-- ID: 4666
-- Scroll of Paralyze
-- Teaches the white magic Paralyze
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(58)
end

function onItemUse(target)
    target:addSpell(58)
end
