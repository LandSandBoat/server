-----------------------------------------
-- ID: 4772
-- Scroll of Thunder
-- Teaches the black magic Thunder
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(164)
end

function onItemUse(target)
    target:addSpell(164)
end
