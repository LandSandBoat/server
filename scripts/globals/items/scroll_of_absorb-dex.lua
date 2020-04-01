-----------------------------------------
-- ID: 4875
-- Scroll of Absorb-DEX
-- Teaches the black magic Absorb-DEX
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(267)
end

function onItemUse(target)
    target:addSpell(267)
end
