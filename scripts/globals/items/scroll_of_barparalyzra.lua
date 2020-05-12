-----------------------------------------
-- ID: 4696
-- Scroll of Barparalyzra
-- Teaches the white magic Barparalyzra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(88)
end

function onItemUse(target)
    target:addSpell(88)
end
