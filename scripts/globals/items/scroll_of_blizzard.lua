-----------------------------------------
-- ID: 4757
-- Scroll of Blizzard
-- Teaches the black magic Blizzard
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(149)
end

function onItemUse(target)
    target:addSpell(149)
end
