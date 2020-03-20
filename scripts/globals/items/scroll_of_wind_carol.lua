-----------------------------------------
-- ID: 5048
-- Scroll of Wind Carol
-- Teaches the song Wind Carol
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(440)
end

function onItemUse(target)
    target:addSpell(440)
end
