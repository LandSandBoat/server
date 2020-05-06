-----------------------------------------
-- ID: 4621
-- Scroll of Raise II
-- Teaches the white magic Raise II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(13)
end

function onItemUse(target)
    target:addSpell(13)
end
