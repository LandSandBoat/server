-----------------------------------------
-- ID: 4771
-- Scroll of Stone V
-- Teaches the black magic Stone V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(163)
end

function onItemUse(target)
    target:addSpell(163)
end
