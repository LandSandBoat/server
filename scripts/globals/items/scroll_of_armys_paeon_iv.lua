-----------------------------------------
-- ID: 4989
-- Scroll of Armys Paeton IV
-- Teaches the song Armys Paeton IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(381)
end

function onItemUse(target)
    target:addSpell(381)
end
