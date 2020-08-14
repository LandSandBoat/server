-----------------------------------------
-- ID: 4708
-- Scroll of Enfire
-- Teaches the white magic Enfire
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(100)
end

function onItemUse(target)
    target:addSpell(100)
end
