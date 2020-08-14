-----------------------------------------
-- ID: 4850
-- Scroll of Refresh II
-- Teaches the white magic Refresh II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(473)
end

function onItemUse(target)
    target:addSpell(473)
end
