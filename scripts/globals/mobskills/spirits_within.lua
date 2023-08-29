-----------------------------------
-- Spirits Within
--
-- Description: Delivers an unavoidable attack. Damage varies with HP and TP.
-- Type: Magical/Breath
-- Utsusemi/Blink absorb: Ignores shadows and most damage reduction.
-- Range: Melee
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == 4249 then -- Volker@Throne_Room only
        target:showText(mob, zones[xi.zone.THRONE_ROOM].text.RETURN_TO_THE_DARKNESS)
    end

    local tp = skill:getTP()
    local hp = mob:getHP()
    local dmg = 0

    -- spirits within for monsters no longer takes TP into consideration - This was causing it to WILDLY do more damage than it was sopposed to
    -- it is now more inline with retail captures also was going 2.5x damage

    dmg = math.floor(hp * (math.floor(0.016 * tp) + 16) / 256)

    dmg = target:breathDmgTaken(dmg)

    -- Handling phalanx
    dmg = dmg - target:getMod(xi.mod.PHALANX)

    if dmg < 0 then
        return 0
    end

    dmg = utils.rampart(target, dmg)
    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:wakeUp()
        target:updateEnmityFromDamage(mob, dmg)
    end

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.ELEMENTAL)
    return dmg
end

return mobskillObject
