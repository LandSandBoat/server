-----------------------------------
-- Ability: Mijin Gakure
-- Sacrifices user's life to deal damage to an enemy.
-- Obtained: Ninja Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local dmg    = player:getHP() * 0.8 + player:getMainLvl() / 0.5
    local resist = xi.mobskills.applyPlayerResistance(player, nil, target, player:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, xi.magic.ele.NONE)

    -- Job Point Bonus (3% per Level)
    dmg = dmg * (1 + (player:getJobPointLevel(xi.jp.MIJIN_GAKURE_EFFECT) * 0.03))
    dmg = dmg * resist
    dmg = utils.stoneskin(target, dmg)

    target:takeDamage(dmg, player, xi.attackType.SPECIAL, xi.damageType.ELEMENTAL)
    player:setLocalVar("MijinGakure", 1)
    player:setHP(0)

    return dmg
end

return abilityObject
