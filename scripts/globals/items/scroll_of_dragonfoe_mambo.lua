-----------------------------------------
-- ID: 5012
-- Scroll of Dragonfoe Mambo
-- Teaches the song Dragonfoe Mambo
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(404)
end

function onItemUse(target)
    target:addSpell(404)
end
