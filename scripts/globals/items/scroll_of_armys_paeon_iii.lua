-----------------------------------------
-- ID: 4988
-- Scroll of Armys Paeton III
-- Teaches the song Armys Paeton III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(380)
end

function onItemUse(target)
    target:addSpell(380)
end
