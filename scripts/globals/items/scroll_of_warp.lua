-----------------------------------------
-- ID: 4869
-- Scroll of Warp
-- Teaches the black magic Warp
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(261)
end

function onItemUse(target)
    target:addSpell(261)
end
