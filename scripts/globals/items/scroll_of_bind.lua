-----------------------------------------
-- ID: 4866
-- Scroll of Bind
-- Teaches the black magic Bind
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(258)
end

function onItemUse(target)
    target:addSpell(258)
end
