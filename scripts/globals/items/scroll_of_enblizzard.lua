-----------------------------------------
-- ID: 4709
-- Scroll of Enblizzard
-- Teaches the white magic Enblizzard
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(101)
end

function onItemUse(target)
    target:addSpell(101)
end
