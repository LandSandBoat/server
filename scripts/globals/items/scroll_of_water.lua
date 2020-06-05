-----------------------------------------
-- ID: 4777
-- Scroll of Water
-- Teaches the black magic Water
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(169)
end

function onItemUse(target)
    target:addSpell(169)
end
