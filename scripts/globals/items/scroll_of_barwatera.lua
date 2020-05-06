-----------------------------------------
-- ID: 4679
-- Scroll of Barwatera
-- Teaches the white magic Barwatera
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(71)
end

function onItemUse(target)
    target:addSpell(71)
end
