-----------------------------------
-- ID: 6475
-- Item: pair_of_lucid_wings_ii
-- Item Effect: Grants 1000 TP to Party members within 10'
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:forMembersInRange(10, function(member)
        member:addTP(1000)
    end)
end

return item_object
