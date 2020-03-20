-----------------------------------------
-- ID: 4748
-- Scroll of Raise II
-- Teaches the white magic Raise III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(140)
end

function onItemUse(target)
    target:addSpell(140)
end
