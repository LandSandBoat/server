-----------------------------------------
-- ID: 5013
-- Scroll of Fowl Aubade
-- Teaches the song Fowl Aubade
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(405)
end

function onItemUse(target)
    target:addSpell(405)
end
