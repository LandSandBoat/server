-----------------------------------------
-- ID: 5014
-- Scroll of Herb Pastoral
-- Teaches the song Herb Pastoral
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(406)
end

function onItemUse(target)
    target:addSpell(406)
end
