-----------------------------------------
-- ID: 4740
-- Scroll of Shellra III
-- Teaches the white magic Shellra III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(132)
end

function onItemUse(target)
    target:addSpell(132)
end
