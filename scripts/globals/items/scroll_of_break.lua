-----------------------------------------
-- ID: 4863
-- Scroll of Break
-- Teaches the black magic Break
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(255)
end

function onItemUse(target)
    target:addSpell(255)
end
