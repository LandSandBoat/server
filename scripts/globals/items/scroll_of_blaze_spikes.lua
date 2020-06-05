-----------------------------------------
-- ID: 4857
-- Scroll of Blaze Spikes
-- Teaches the black magic Blaze Spikes
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(249)
end

function onItemUse(target)
    target:addSpell(249)
end
