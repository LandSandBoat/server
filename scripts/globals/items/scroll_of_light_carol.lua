-----------------------------------------
-- ID: 5052
-- Scroll of Light Carol
-- Teaches the song Light Carol
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(444)
end

function onItemUse(target)
    target:addSpell(444)
end
