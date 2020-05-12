-----------------------------------------
-- ID: 4751
-- Scroll of Erase
-- Teaches the white magic Erase
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(143)
end

function onItemUse(target)
    target:addSpell(143)
end
