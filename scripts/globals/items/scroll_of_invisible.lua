-----------------------------------------
-- ID: 4744
-- Scroll of Invisible
-- Teaches the white magic Invisible
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(136)
end

function onItemUse(target)
    target:addSpell(136)
end
