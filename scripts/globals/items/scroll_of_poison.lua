-----------------------------------------
-- ID: 4828
-- Scroll of Poison
-- Teaches the black magic Poison
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(220)
end

function onItemUse(target)
    target:addSpell(220)
end
