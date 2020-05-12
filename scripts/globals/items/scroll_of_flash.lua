-----------------------------------------
-- ID: 4720
-- Scroll of Flash
-- Teaches the white magic Flash
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(112)
end

function onItemUse(target)
    target:addSpell(112)
end
