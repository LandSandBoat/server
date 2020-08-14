-----------------------------------------
-- ID: 5049
-- Scroll of Earth Carol
-- Teaches the song Earth Carol
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(441)
end

function onItemUse(target)
    target:addSpell(441)
end
