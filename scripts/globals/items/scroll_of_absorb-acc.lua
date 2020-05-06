-----------------------------------------
-- ID: 4886
-- Scroll of Absorb-ACC
-- Teaches the black magic Absorb-ACC
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(242)
end

function onItemUse(target)
    target:addSpell(242)
end
