-----------------------------------
-- ID: 18160
-- Item: Spartan Bullet
-- Additional Effect: Stun
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 50
    if (target:getMainLvl() > player:getMainLvl()) then
        chance = chance - 5 * (target:getMainLvl() - player:getMainLvl())
        chance = utils.clamp(chance, 5, 50)
    end
    if (math.random(0, 50) >= chance or applyResistanceAddEffect(player, target, xi.magic.ele.LIGHTNING, 0) <= 0.5) then
        return 0, 0, 0
    else
        if (not target:hasStatusEffect(xi.effect.STUN)) then
            target:addStatusEffect(xi.effect.STUN, 1, 0, 4)
        end
        return xi.subEffect.STUN, xi.msg.basic.ADD_EFFECT_STATUS, xi.effect.STUN
    end
end

return item_object
