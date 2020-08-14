-----------------------------------------
-- ID: 4823
-- Scroll of Flood II
-- Teaches the black magic Flood II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(215)
end

function onItemUse(target)
    target:addSpell(215)
end
