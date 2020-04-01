-----------------------------------------
-- ID: 4668
-- Scroll of Barfire
-- Teaches the white magic Barfire
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(60)
end

function onItemUse(target)
    target:addSpell(60)
end
