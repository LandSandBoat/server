-----------------------------------
-- ID: 5354
-- Item: Flask of Walahra Water
-- Item Effect: Restores 5% of maximum HP and MP
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, player, item, action)
    local hp = math.floor(target:getMaxHP() * 0.05)
    local mp = math.floor(target:getMaxMP() * 0.05)

    target:addHP(hp)
    target:addMP(mp)
    action:messageID(target:getID(), xi.msg.basic.RECOVERS_HP_AND_MP)

    return hp
end

return itemObject
