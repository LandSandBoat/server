-----------------------------------
-- Area: Navukgo Execution Chamber
--   NM: Two-faced Flan
-----------------------------------
---@type TMobEntity
local entity = {}

local function smooth(mob)
    mob:setAnimationSub(1)
    mob:setMagicCastingEnabled(true)
    mob:setMod(xi.mod.DMGPHYS, -3300)
    mob:setMod(xi.mod.DMGMAGIC, 0)
    mob:setMod(xi.mod.REGAIN, 0)
    mob:setLocalVar('spikesTime', os.time() + math.random(45, 60))
end

local function spikes(mob)
    mob:setAnimationSub(2)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.DMGMAGIC, -3300)
    mob:setMod(xi.mod.DMGPHYS, 0)
    mob:setMod(xi.mod.REGAIN, 300)
end

entity.onMobInitialize = function(mob)
    mob:addListener('TAKE_DAMAGE', 'TAKE_DAMAGE_FLAN', function(mobArg, damage, attacker, attackType, damageType)
        if
            mob:getAnimationSub() == 1 and
            (attackType == xi.attackType.PHYSICAL or attackType == xi.attackType.RANGED) and
            os.time() >= mobArg:getLocalVar('spikesTime')
        then
            spikes(mobArg)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REFRESH, 100)
    mob:setMod(xi.mod.SILENCERES, 50)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 5)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 0)
    smooth(mob)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.mobSkill.XENOGLOSSIA then
        smooth(mob)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
