-----------------------------------------
-- ID: 4618
-- Scroll of Curaga IV
-- Teaches the white magic Curaga IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(10)
end

function onItemUse(target)
    target:addSpell(10)
end
