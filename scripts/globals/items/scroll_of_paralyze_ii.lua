-----------------------------------------
-- ID: 6570
-- Scroll of Paralyze II
-- Teaches the white magic Paralyze II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(80)
end

function onItemUse(target)
    target:addSpell(80)
end
