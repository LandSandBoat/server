-----------------------------------------
-- ID: 4861
-- Scroll of Sleep
-- Teaches the black magic Sleep
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(253)
end

function onItemUse(target)
    target:addSpell(253)
end
