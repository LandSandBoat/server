-----------------------------------------
-- ID: 4770
-- Scroll of Stone IV
-- Teaches the black magic Stone IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(162)
end

function onItemUse(target)
    target:addSpell(162)
end
