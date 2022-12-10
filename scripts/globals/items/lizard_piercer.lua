-----------------------------------
-- ID: 16853
-- Item: Lizard Piercer
-- Additional Effect: Ice damage vs lizards
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onAdditionalEffect = function(player, target, damage)
    local chance = 100
    print(1)

    if math.random(100) <= chance then
        damage = xi.additionalEffect.calcDamage(player, xi.damage.ICE, target, damage)
        msgID  = xi.msg.basic.ADD_EFFECT_DMG

        if damage < 0 then
            msgID = xi.msg.basic.ADD_EFFECT_HEAL
        end

        msgParam = damage
        return damage
    end

    return 0, 0, 0
end

return itemObject
