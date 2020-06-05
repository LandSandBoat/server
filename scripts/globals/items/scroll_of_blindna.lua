-----------------------------------------
-- ID: 4624
-- Scroll of Blindna
-- Teaches the white magic Blindna
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(16)
end

function onItemUse(target)
    target:addSpell(16)
end
