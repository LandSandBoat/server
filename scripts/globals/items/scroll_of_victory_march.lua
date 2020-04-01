-----------------------------------------
-- ID: 5028
-- Scroll of Victory March
-- Teaches the song Victory March
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(420)
end

function onItemUse(target)
    target:addSpell(420)
end
