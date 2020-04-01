-----------------------------------------
-- ID: 4622
-- Scroll of Poisona
-- Teaches the white magic Poisona
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(14)
end

function onItemUse(target)
    target:addSpell(14)
end
