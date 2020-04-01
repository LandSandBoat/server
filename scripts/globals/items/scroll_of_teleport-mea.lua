-----------------------------------------
-- ID: 4732
-- Scroll of Teleport-Mea
-- Teaches the white magic Teleport-Mea
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(124)
end

function onItemUse(target)
    target:addSpell(124)
end
