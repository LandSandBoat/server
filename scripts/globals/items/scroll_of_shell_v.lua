-----------------------------------------
-- ID: 4660
-- Scroll of Shell V
-- Teaches the white magic Shell V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(52)
end

function onItemUse(target)
    target:addSpell(52)
end
