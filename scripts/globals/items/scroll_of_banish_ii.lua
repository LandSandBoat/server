-----------------------------------------
-- ID: 4637
-- Scroll of Banish II
-- Teaches the white magic Banish II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(29)
end

function onItemUse(target)
    target:addSpell(29)
end
