-----------------------------------------
-- ID: 4726
-- Scroll of Enthunder II
-- Teaches the white magic Enthunder II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(316)
end

function onItemUse(target)
    target:addSpell(316)
end
