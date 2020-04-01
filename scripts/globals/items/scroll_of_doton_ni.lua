-----------------------------------------
-- ID: 4938
-- Scroll of Doton: ni
-- Teaches the ninjutsu Doton: ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(330)
end

function onItemUse(target)
    target:addSpell(330)
end
