-----------------------------------------
-- ID: 4717
-- Scroll of Refresh
-- Teaches the white magic Refresh
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(109)
end

function onItemUse(target)
    target:addSpell(109)
end
