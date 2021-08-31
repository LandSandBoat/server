-----------------------------------
-- ID: 16543
-- Item: Fire Sword
-- Additional Effect: Fire Damage
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 5

    if (math.random(0, 99) >= chance) then
        return 0, 0, 0
    else
        local dmg = math.random(3, 10)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, xi.magic.ele.FIRE, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, xi.magic.ele.FIRE, 0)
        dmg = adjustForTarget(target, dmg, xi.magic.ele.FIRE)
        dmg = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.FIRE, dmg)

        local message = xi.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = xi.msg.basic.ADD_EFFECT_HEAL
        end

        return xi.subEffect.FIRE_DAMAGE, message, dmg
    end
end

return item_object
