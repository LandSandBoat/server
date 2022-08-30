-----------------------------------
-- ID: 26165
-- Item: facility ring
-- Capacity point bonus
-----------------------------------
-- Bonus: +150%
-- Duration: 720 min
-- Max bonus: 30000 cp
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.COMMITMENT) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
   target:addStatusEffect(xi.effect.COMMITMENT, 150, 0, 43200, 0, 30000)
end

return item_object
