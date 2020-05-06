-----------------------------------------
-- ID: 5007
-- Scroll of Sword Madrigal
-- Teaches the song Sword Madrigal
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(399)
end

function onItemUse(target)
    target:addSpell(399)
end
