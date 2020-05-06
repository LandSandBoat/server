-----------------------------------------
-- ID: 4789
-- Scroll of Blizzaga III
-- Teaches the black magic Blizzaga III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(181)
end

function onItemUse(target)
    target:addSpell(181)
end
