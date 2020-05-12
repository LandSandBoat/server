-----------------------------------------
-- ID: 4725
-- Scroll of Enstone II
-- Teaches the white magic Enstone II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(315)
end

function onItemUse(target)
    target:addSpell(315)
end
