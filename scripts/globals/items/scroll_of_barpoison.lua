-----------------------------------------
-- ID: 4681
-- Scroll of Barpoison
-- Teaches the white magic Barpoison
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(73)
end

function onItemUse(target)
    target:addSpell(73)
end
