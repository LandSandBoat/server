-----------------------------------------
-- ID: 4712
-- Scroll of Enthunder
-- Teaches the white magic Enthunder
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(104)
end

function onItemUse(target)
    target:addSpell(104)
end
