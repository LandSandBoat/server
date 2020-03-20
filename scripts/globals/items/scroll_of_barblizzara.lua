-----------------------------------------
-- ID: 4675
-- Scroll of Barblizzara
-- Teaches the white magic Barblizzara
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(67)
end

function onItemUse(target)
    target:addSpell(67)
end
