-----------------------------------------
-- ID: 4991
-- Scroll of Armys Paeton VI
-- Teaches the song Armys Paeton VI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(383)
end

function onItemUse(target)
    target:addSpell(383)
end
