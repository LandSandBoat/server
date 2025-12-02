-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Purson
-- KSNM: The Scarlet King
-----------------------------------
---@type TMobEntity
local entity = {}
    -- Set Immunities
entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

    -- Set Modifiers
entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false) -- Does not cast spells.
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('BloodWeaponTimer', GetSystemTime() + 15)  -- First use of Blood Weapon is 15 seconds after engaging.
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('BloodWeaponTimer') < GetSystemTime() then
        mob:useMobAbility(xi.jobSpecialAbility.BLOOD_WEAPON) -- Blood Weapon
        mob:setLocalVar('BloodWeaponTimer', GetSystemTime() + 40) -- Will use Blood Weapon every 40 seconds.
    end
end

entity.onMobSkillTarget = function(target, mob, skill) -- Will reset enmity on main target when using Great Whirlwind
    local skillID = skill:getID()
    if skillID == xi.mobSkill.GREAT_WHIRLWIND_1 then
        mob:resetEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
