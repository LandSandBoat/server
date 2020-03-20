-----------------------------------------
-- ID: 4769
-- Scroll of Stone III
-- Teaches the black magic Stone III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(161)
end

function onItemUse(target)
    target:addSpell(161)
end
