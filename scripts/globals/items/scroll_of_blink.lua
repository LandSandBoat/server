-----------------------------------------
-- ID: 4661
-- Scroll of Blink
-- Teaches the white magic Blink
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(53)
end

function onItemUse(target)
    target:addSpell(53)
end
