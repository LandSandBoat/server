-----------------------------------------
-- ID: 15793
-- Item: Anniversary Ring
-- Experience point bonus
-----------------------------------------
-- Bonus: +100%
-- Duration: 720 min
-- Max bonus: 3000 exp
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
    target:addStatusEffect(tpz.effect.DEDICATION, 100, 0, 86400, 0, 6000)
end
