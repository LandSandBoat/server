-----------------------------------------
-- ID: 4860
-- Scroll of Stun
-- Teaches the black magic Stun
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(252)
end

function onItemUse(target)
    target:addSpell(252)
end
