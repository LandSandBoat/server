-----------------------------------------
-- ID: 4745
-- Scroll of Sneak
-- Teaches the white magic Sneak
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(137)
end

function onItemUse(target)
    target:addSpell(137)
end
