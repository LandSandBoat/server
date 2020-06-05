-----------------------------------------
-- ID: 4623
-- Scroll of Paralyna
-- Teaches the white magic Paralyna
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(15)
end

function onItemUse(target)
    target:addSpell(15)
end
