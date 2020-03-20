-----------------------------------------
-- ID: 5047
-- Scroll of Ice Carol
-- Teaches the song Ice Carol
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(439)
end

function onItemUse(target)
    target:addSpell(439)
end
