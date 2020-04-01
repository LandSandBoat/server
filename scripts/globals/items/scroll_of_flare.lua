-----------------------------------------
-- ID: 4812
-- Scroll of Flare
-- Teaches the black magic Flare
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(204)
end

function onItemUse(target)
    target:addSpell(204)
end
