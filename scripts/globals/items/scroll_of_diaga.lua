-----------------------------------------
-- ID: 4641
-- Scroll of Diaga
-- Teaches the white magic Diaga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(33)
end

function onItemUse(target)
    target:addSpell(33)
end
