-----------------------------------
-- ID: 5322
-- Item: flask_of_healing_powder
-- Item Effect: Restores 25% of Maximum HP to Party members within 10'
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(10, function(member)
        member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, member:addHP((member:getMaxHP() / 100) * 25))
    end)
end

return itemObject
