-----------------------------------------
-- ID: 5046
-- Scroll of Fire Carol
-- Teaches the song Fire Carol
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(438)
end

function onItemUse(target)
    target:addSpell(438)
end
