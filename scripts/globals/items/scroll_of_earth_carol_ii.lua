-----------------------------------------
-- ID: 5057
-- Scroll of Earth Carol II
-- Teaches the song Earth Carol II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(449)
end

function onItemUse(target)
    target:addSpell(449)
end
