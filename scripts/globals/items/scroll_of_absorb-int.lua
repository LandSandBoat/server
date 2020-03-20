-----------------------------------------
-- ID: 4878
-- Scroll of Absorb-INT
-- Teaches the black magic Absorb-INT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(270)
end

function onItemUse(target)
    target:addSpell(270)
end
