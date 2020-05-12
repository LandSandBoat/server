-----------------------------------------
-- ID: 4798
-- Scroll of Stonega II
-- Teaches the black magic Stonega II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(190)
end

function onItemUse(target)
    target:addSpell(190)
end
