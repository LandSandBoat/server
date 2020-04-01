-----------------------------------------
-- ID: 5027
-- Scroll of Advancing March
-- Teaches the song Advancing March
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(419)
end

function onItemUse(target)
    target:addSpell(419)
end
