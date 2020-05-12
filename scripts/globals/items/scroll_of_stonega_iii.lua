-----------------------------------------
-- ID: 4799
-- Scroll of Stonega III
-- Teaches the black magic Stonega III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(191)
end

function onItemUse(target)
    target:addSpell(191)
end
