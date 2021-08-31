-----------------------------------
-- ID: 17071
-- Item: Heat Rod
-- Additional Effect: Lightning Damage
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local chance = 10

    if (math.random(0, 99) >= chance) then
        return 0, 0, 0
    else
        local dmg = math.random(5, 20)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, xi.magic.ele.LIGHTNING, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, xi.magic.ele.LIGHTNING, 0)
        dmg = adjustForTarget(target, dmg, xi.magic.ele.LIGHTNING)
        dmg = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.LIGHTNING, dmg)

        local message = xi.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = xi.msg.basic.ADD_EFFECT_HEAL
        end

        return xi.subEffect.LIGHTNING_DAMAGE, message, dmg
    end
end

return item_object
