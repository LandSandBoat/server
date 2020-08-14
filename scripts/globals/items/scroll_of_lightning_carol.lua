-----------------------------------------
-- ID: 5050
-- Scroll of Lightning Carol
-- Teaches the song Lightning Carol
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(442)
end

function onItemUse(target)
    target:addSpell(442)
end
