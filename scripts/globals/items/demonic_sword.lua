-----------------------------------
-- ID: 16936
-- Item: Demonic Sword
-- Additional Effect: Darkness Damage
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
        local dmg = math.random(5, 21)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, xi.magic.ele.DARK, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, xi.magic.ele.DARK, 0)
        dmg = adjustForTarget(target, dmg, xi.magic.ele.DARK)
        dmg = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.DARK, dmg)

        local message = xi.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = xi.msg.basic.ADD_EFFECT_HEAL
        end

        return xi.subEffect.DARKNESS_DAMAGE, message, dmg
    end
end

return item_object
