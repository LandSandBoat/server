-----------------------------------------
-- ID: 4680
-- Scroll of Barsleep
-- Teaches the white magic Barsleep
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(72)
end

function onItemUse(target)
    target:addSpell(72)
end
