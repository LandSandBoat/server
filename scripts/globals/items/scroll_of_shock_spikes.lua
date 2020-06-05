-----------------------------------------
-- ID: 4859
-- Scroll of Shock Spikes
-- Teaches the black magic Shock Spikes
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(251)
end

function onItemUse(target)
    target:addSpell(251)
end
