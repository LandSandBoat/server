-----------------------------------------
-- ID: 4736
-- Scroll of Protectra IV
-- Teaches the white magic Protectra IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(128)
end

function onItemUse(target)
    target:addSpell(128)
end
