-----------------------------------------
-- ID: 4871
-- Scroll of Escape
-- Teaches the black magic Escape
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(263)
end

function onItemUse(target)
    target:addSpell(263)
end
