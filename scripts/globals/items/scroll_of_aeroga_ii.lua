-----------------------------------------
-- ID: 4793
-- Scroll of Aeroga II
-- Teaches the black magic Aeroga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(185)
end

function onItemUse(target)
    target:addSpell(185)
end
