-----------------------------------------
-- ID: 4627
-- Scroll of Viruna
-- Teaches the white magic Viruna
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(19)
end

function onItemUse(target)
    target:addSpell(19)
end
