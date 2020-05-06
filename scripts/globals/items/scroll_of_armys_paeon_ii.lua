-----------------------------------------
-- ID: 4987
-- Scroll of Armys Paeton II
-- Teaches the song Armys Paeton II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(379)
end

function onItemUse(target)
    target:addSpell(379)
end
