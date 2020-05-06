-----------------------------------------
-- ID: 4839
-- Scroll of Bio II
-- Teaches the black magic Bio II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(231)
end

function onItemUse(target)
    target:addSpell(231)
end
