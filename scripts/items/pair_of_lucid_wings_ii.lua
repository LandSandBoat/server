-----------------------------------
-- ID: 6475
-- Item: pair_of_lucid_wings_ii
-- Item Effect: Grants 1000 TP to Party members within 10'
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(10, function(member)
        member:addTP(1000)
    end)
end

return itemObject
