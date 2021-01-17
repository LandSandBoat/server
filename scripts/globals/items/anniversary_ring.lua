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
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.DEDICATION) == true) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.DEDICATION, 100, 0, 43200, 0, 3000)
end

return item_object
