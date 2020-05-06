-----------------------------------------
-- ID: 4678
-- Scroll of Barthundra
-- Teaches the white magic Barthundra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(70)
end

function onItemUse(target)
    target:addSpell(70)
end
