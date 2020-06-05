-----------------------------------------
-- ID: 4760
-- Scroll of Blizzard IV
-- Teaches the black magic Blizzard IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(152)
end

function onItemUse(target)
    target:addSpell(152)
end
