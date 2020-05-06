-----------------------------------------
-- ID: 4780
-- Scroll of Water IV
-- Teaches the black magic Water IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(172)
end

function onItemUse(target)
    target:addSpell(172)
end
