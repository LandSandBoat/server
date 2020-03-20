-----------------------------------------
-- ID: 4829
-- Scroll of Poison II
-- Teaches the black magic Poison II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(221)
end

function onItemUse(target)
    target:addSpell(221)
end
