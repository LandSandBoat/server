-----------------------------------
-- ID: 5833
-- Item: flask_of_mana_mist
-- Item Effect: Restores 300 MP to Party members within 10'
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(10, function(member)
        member:messageBasic(xi.msg.basic.RECOVERS_MP, 0, member:addMP(300 * xi.settings.main.ITEM_POWER))
    end)
end

return itemObject
