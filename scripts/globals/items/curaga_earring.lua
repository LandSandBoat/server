-----------------------------------
-- ID: 14759
-- Item: Curaga Earring
-- Item Effect: Casts Curaga
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/settings")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:forMembersInRange(30, function(member)
        local healAmount = math.random(60, 90)

        healAmount = healAmount + (healAmount * (member:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))
        healAmount = healAmount * xi.settings.main.CURE_POWER

        local diff = (member:getMaxHP() - member:getHP())
        if healAmount > diff then
            healAmount = diff
        end

        member:addHP(healAmount)
        member:messageBasic(xi.msg.basic.RECOVERS_HP, 0, healAmount)
    end)
end

return itemObject
