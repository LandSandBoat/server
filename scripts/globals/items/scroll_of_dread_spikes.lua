-----------------------------------------
-- ID: 4885
-- Scroll of Dread Spikes
-- Teaches the black magic Dread Spikes
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(277)
end

function onItemUse(target)
    target:addSpell(277)
end
