-----------------------------------------
-- ID: 4684
-- Scroll of Barsilence
-- Teaches the white magic Barsilence
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(76)
end

function onItemUse(target)
    target:addSpell(76)
end
