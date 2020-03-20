-----------------------------------------
-- ID: 4755
-- Scroll of Fire IV
-- Teaches the black magic Fire IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(147)
end

function onItemUse(target)
    target:addSpell(147)
end
