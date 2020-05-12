-----------------------------------------
-- ID: 4657
-- Scroll of Shell II
-- Teaches the white magic Shell II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(49)
end

function onItemUse(target)
    target:addSpell(49)
end
