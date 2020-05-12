-----------------------------------------
-- ID: 4813
-- Scroll of Flare II
-- Teaches the black magic Flare II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(205)
end

function onItemUse(target)
    target:addSpell(205)
end
