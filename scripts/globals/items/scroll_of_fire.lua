-----------------------------------------
-- ID: 4752
-- Scroll of Fire
-- Teaches the black magic Fire
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(144)
end

function onItemUse(target)
    target:addSpell(144)
end
