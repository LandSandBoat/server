-----------------------------------------
-- ID: 4986
-- Scroll of Armys Paeton
-- Teaches the song Armys Paeton
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(378)
end

function onItemUse(target)
    target:addSpell(378)
end
