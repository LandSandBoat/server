-----------------------------------
-- Bomb Toss - Suicide
-- Throws a bomb at an enemy. Sometimes backfires (bomb_toss.lua)
-- This needs to be set to do 1/3 of the mob's current HP.
-- 15% chance to use bomb_toss_suicide if bomb_toss is picked (50%)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    --[[
    BombToss Suicide should happen approx 15% of the time a goblin throws a bomb
    goblin_rush and bomb_toss are assumed to be close to 50/50 activation rate
    This nets a roughly 7.5% activation rate.

    To achieve a 7.5% activation we have to consider how a mob skill is chosen.
    The entire skill list is shuffled and then checked starting from the first element.
    In this scenario we have 3 skills to consider resulting in a ~33% chance for each
    .: we should set bomb_toss_suicide's threshold to be 23%.  33% * 23% = ~7.5%
    This gives us a roughly 46% goblin_rush rate and a combined ~54% bomb_toss rate
    Not exactly 50% goblin_rush 35% bomb_toss and 15% bomb_toss_suicide

    A more involved fix is one of the following:
    - Changing the mob skill list to support weighting (we currently do this mob by mob in OnMobWeaponSkillPrepare)
    - Changing OnMobWeaponSkillPrepare to support a family level check (perhaps loading a family mixin file and looking for OnMobWeaponSkillPrepare)
    - Adding a mixin (and a lua file) for every goblin in vanadiel (there are a lot of goblins. lets not do that)
    Its worth nothing that I am only aware of two families which would make use of this.  Goblins and Moblins
    ]]

    local suicideCheck = math.random(0, 100)
    if
        not mob:isNM() and
        not mob:isInDynamis() and -- Campaign too eventually
        suicideCheck <= 23
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = skill:getMobHP() / 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
