-----------------------------------------
-- ID: 4773
-- Scroll of Thunder II
-- Teaches the black magic Thunder II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(165)
end

function onItemUse(target)
    target:addSpell(165)
end
