-----------------------------------------
-- ID: 4809
-- Scroll of Waterga III
-- Teaches the black magic Waterga III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(201)
end

function onItemUse(target)
    target:addSpell(201)
end
