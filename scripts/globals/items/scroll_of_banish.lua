-----------------------------------------
-- ID: 4636
-- Scroll of Banish
-- Teaches the white magic Banish
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(28)
end

function onItemUse(target)
    target:addSpell(28)
end
