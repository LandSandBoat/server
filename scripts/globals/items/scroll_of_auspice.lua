-----------------------------------------
-- ID: 4704
-- Scroll of Auspice
-- Teaches the white magic Auspice
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(96)
end

function onItemUse(target)
    target:addSpell(96)
end
