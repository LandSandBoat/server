-----------------------------------------
-- ID: 4615
-- Scroll of Curaga
-- Teaches the white magic Curaga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(7)
end

function onItemUse(target)
    target:addSpell(7)
end
