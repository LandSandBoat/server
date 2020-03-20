-----------------------------------------
-- ID: 4879
-- Scroll of Absorb-MND
-- Teaches the black magic Absorb-MND
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(271)
end

function onItemUse(target)
    target:addSpell(271)
end
