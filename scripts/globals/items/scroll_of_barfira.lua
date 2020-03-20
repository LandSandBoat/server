-----------------------------------------
-- ID: 4674
-- Scroll of Barfira
-- Teaches the white magic Barfira
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(66)
end

function onItemUse(target)
    target:addSpell(66)
end
