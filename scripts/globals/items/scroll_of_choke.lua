-----------------------------------------
-- ID: 4845
-- Scroll of Choke
-- Teaches the black magic Choke
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(237)
end

function onItemUse(target)
    target:addSpell(237)
end
