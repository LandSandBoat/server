-----------------------------------------
-- ID: 4762
-- Scroll of Aero
-- Teaches the black magic Aero
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(154)
end

function onItemUse(target)
    target:addSpell(154)
end
