-----------------------------------------
-- ID: 4659
-- Scroll of Shell IV
-- Teaches the white magic Shell IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(51)
end

function onItemUse(target)
    target:addSpell(51)
end
