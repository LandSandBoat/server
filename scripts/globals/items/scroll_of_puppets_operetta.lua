-----------------------------------------
-- ID: 5018
-- Scroll of Puppets Operetta
-- Teaches the song Puppets Operetta
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(410)
end

function onItemUse(target)
    target:addSpell(410)
end
