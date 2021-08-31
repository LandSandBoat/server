-----------------------------------
-- ID: 16613
-- Spirit Sword
-- Additional effect: Light damage
-- Enchantment: TP+100
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
        local dmg = math.random(7, 21)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, xi.magic.ele.LIGHT, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player, target, xi.magic.ele.LIGHT, 0)
        dmg = adjustForTarget(target, dmg, xi.magic.ele.LIGHT)
        dmg = finalMagicNonSpellAdjustments(player, target, xi.magic.ele.LIGHT, dmg)

        local message = xi.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = xi.msg.basic.ADD_EFFECT_HEAL
        end

        return xi.subEffect.LIGHT_DAMAGE, message, dmg
    end
end

item_object.onItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

item_object.onItemUse = function(target)
    target:addTP(100)
end

return item_object
