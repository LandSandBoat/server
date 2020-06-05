-----------------------------------------
-- ID: 4902
-- Light Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(294)
end

function onItemUse(target)
    target:addSpell(294)
end
