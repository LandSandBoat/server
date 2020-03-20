-----------------------------------------
-- ID: 4855
-- Scroll of Aspir
-- Teaches the black magic Aspir
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(247)
end

function onItemUse(target)
    target:addSpell(247)
end
