-----------------------------------------
-- ID: 4822
-- Scroll of Flood
-- Teaches the black magic Flood
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(214)
end

function onItemUse(target)
    target:addSpell(214)
end
