-----------------------------------------
-- ID: 5023
-- Scroll of Goblin Gavotte
-- Teaches the song Goblin Gavotte
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(415)
end

function onItemUse(target)
    target:addSpell(415)
end
