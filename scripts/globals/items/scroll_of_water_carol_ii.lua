-----------------------------------------
-- ID: 5059
-- Scroll of Water Carol II
-- Teaches the song Water Carol II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(451)
end

function onItemUse(target)
    target:addSpell(451)
end
