-----------------------------------
-- ID: 15763
-- Item: emperor band
-- Experience point bonus
-----------------------------------
-- Bonus: +50%
-- Duration: 720 min
-- Max bonus: 30000 exp
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(xi.effect.DEDICATION) == true) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.DEDICATION, 50, 0, 43200, 0, 30000)
end

return item_object
