-----------------------------------------
-- ID: 4658
-- Scroll of Shell III
-- Teaches the white magic Shell III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(50)
end

function onItemUse(target)
    target:addSpell(50)
end
