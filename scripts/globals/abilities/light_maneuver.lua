-----------------------------------
-- Ability: Light Maneuver
-- Enhances the effect of light attachments. Must have animator equipped.
-- Obtained: Puppetmaster level 1
-- Recast Time: 10 seconds (shared with all maneuvers)
-- Duration: 1 minute
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (player:getWeaponSubSkillType(xi.slot.RANGED) == 10 and
        not player:hasStatusEffect(xi.effect.OVERLOAD) and
        player:getPet()) then
        return 0, 0
    else
        return 71, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)

    local burden = 15
    if (target:getStat(xi.mod.CHR) < target:getPet():getStat(xi.mod.CHR)) then
        burden = 20
    end

    local overload = target:addBurden(xi.magic.ele.LIGHT-1, burden)

    if (overload ~= 0 and
        (player:getMod(xi.mod.PREVENT_OVERLOAD) > 0 or player:getPet():getMod(xi.mod.PREVENT_OVERLOAD) > 0) and
        player:delStatusEffectSilent(xi.effect.WATER_MANEUVER)) then
        overload = 0
    end

    if (overload ~= 0) then
        target:removeAllManeuvers()
        target:addStatusEffect(xi.effect.OVERLOAD, 0, 0, overload)
    else
        local level
        if (target:getMainJob() == xi.job.PUP) then
            level = target:getMainLvl()
        else
            level = target:getSubLvl()
        end

        local bonus = 1 + (level/15) + target:getMod(xi.mod.MANEUVER_BONUS)

        if (target:getActiveManeuvers() == 3) then
            target:removeOldestManeuver()
        end

        local dur = player:getPet():getLocalVar("MANEUVER_DURATION")
        target:addStatusEffect(xi.effect.LIGHT_MANEUVER, bonus, 0, utils.clamp(dur, 60, 300))

    end

    return xi.effect.LIGHT_MANEUVER
end

return ability_object
