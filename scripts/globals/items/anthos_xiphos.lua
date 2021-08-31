-----------------------------------
-- ID: 17750
-- Item: Anthos Xiphos
-- Additional Effect: Water Damage
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
        local dmg = math.random(4, 11)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, xi.magic.ele.WATER, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0)
        dmg = adjustForTarget(target, dmg, xi.magic.ele.WATER)
        dmg = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.WATER, dmg)

        local message = xi.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = xi.msg.basic.ADD_EFFECT_HEAL
        end

        return xi.subEffect.WATER_DAMAGE, message, dmg
    end
end

return item_object
