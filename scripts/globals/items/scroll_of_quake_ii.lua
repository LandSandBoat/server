-----------------------------------------
-- ID: 4819
-- Scroll of Quake II
-- Teaches the black magic Quake II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(211)
end

function onItemUse(target)
    target:addSpell(211)
end
