-----------------------------------------
-- ID: 4775
-- Scroll of Thunder IV
-- Teaches the black magic Thunder IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(167)
end

function onItemUse(target)
    target:addSpell(167)
end
