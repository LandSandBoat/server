-----------------------------------------
-- ID: 4689
-- Scroll of Recall-Meriph
-- Teaches the white magic Recall-Meriph
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(83)
end

function onItemUse(target)
    target:addSpell(83)
end
