-----------------------------------------
-- ID: 5029
-- Scroll of Battlefield Elegy
-- Teaches the song Battlefield Elegy
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(421)
end

function onItemUse(target)
    target:addSpell(421)
end
