-----------------------------------------
-- ID: 5054
-- Scroll of Fire Carol II
-- Teaches the song Fire Carol II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(446)
end

function onItemUse(target)
    target:addSpell(446)
end
