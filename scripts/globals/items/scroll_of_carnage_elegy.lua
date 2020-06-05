-----------------------------------------
-- ID: 5030
-- Scroll of Carnage Elegy
-- Teaches the song Carnage Elegy
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(422)
end

function onItemUse(target)
    target:addSpell(422)
end
