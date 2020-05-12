-----------------------------------------
-- ID: 4710
-- Scroll of Enaero
-- Teaches the white magic Enaero
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(102)
end

function onItemUse(target)
    target:addSpell(102)
end
