-----------------------------------------
-- ID: 4612
-- Scroll of Cure IV
-- Teaches the white magic Cure IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(4)
end

function onItemUse(target)
    target:addSpell(4)
end
