-----------------------------------------
-- ID: 14671
-- Item: allied ring
-- Experience point bonus
-----------------------------------------
-- Bonus: +150%
-- Duration: 720 min
-- Max bonus: 9000 exp
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.DEDICATION) == true) then
        result = 56
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.DEDICATION, 150, 0, 43200, 0, 9000)
end
