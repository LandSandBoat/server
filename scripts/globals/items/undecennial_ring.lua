-----------------------------------
-- ID: 28528
-- Item: Undecennial Ring
-- Experience point bonus
-----------------------------------
-- Bonus: +100%
-- Duration: 720 min
-- Max bonus: 11111 exp
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.DEDICATION) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
   target:addStatusEffect(xi.effect.DEDICATION, 100, 0, 43200, 0, 11111)
end

return item_object
