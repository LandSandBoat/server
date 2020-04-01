-----------------------------------------
-- ID: 5078
-- Scroll of Sentinel's Scherzo
-- Teaches the song Sentinel's Scherzo
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(470)
end

function onItemUse(target)
    target:addSpell(470)
end
