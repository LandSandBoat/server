-----------------------------------------
-- ID: 4690
-- Scroll of Baramnesia
-- Teaches the white magic Baramnesia
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(84)
end

function onItemUse(target)
    target:addSpell(84)
end
