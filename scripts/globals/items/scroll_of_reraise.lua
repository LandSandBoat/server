-----------------------------------------
-- ID: 4743
-- Scroll of Reraise
-- Teaches the white magic Reraise
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(135)
end

function onItemUse(target)
    target:addSpell(135)
end
