-----------------------------------
-- ID: 5834
-- Item: pair_of_lucid_wings_i
-- Item Effect: Grants 500 TP to Party members within 10'
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(10, function(member)
        member:addTP(500)
    end)
end

return itemObject
