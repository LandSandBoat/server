-----------------------------------------
-- ID: 5011
-- Scroll of Sheepfoe Mambo
-- Teaches the song Sheepfoe Mambo
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(403)
end

function onItemUse(target)
    target:addSpell(403)
end
