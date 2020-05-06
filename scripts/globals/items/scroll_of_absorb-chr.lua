-----------------------------------------
-- ID: 4880
-- Scroll of Absorb-CHR
-- Teaches the black magic Absorb-CHR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(272)
end

function onItemUse(target)
    target:addSpell(272)
end
