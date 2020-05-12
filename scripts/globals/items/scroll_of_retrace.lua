-----------------------------------------
-- ID: 4873
-- Scroll of Retrace
-- Teaches the black magic Retrace
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(241)
end

function onItemUse(target)
    target:addSpell(241)
end
