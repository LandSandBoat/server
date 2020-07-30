-----------------------------------------
-- ID: 14759
-- Item: Curaga Earring
-- Item Effect: Casts Curaga
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/settings")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:forMembersInRange(30, function(member)
        local healAmount = math.random(60, 90)

        healAmount = healAmount + (healAmount * (member:getMod(tpz.mod.CURE_POTENCY_RCVD)/100))
        healAmount = healAmount * CURE_POWER

        local diff = (member:getMaxHP() - member:getHP())
        if (healAmount > diff) then
            healAmount = diff
        end
        member:addHP(healAmount)
        member:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, healAmount)
    end)
end
