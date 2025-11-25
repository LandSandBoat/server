-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -44.180, y = -24.518, z =  511.993 }
}

entity.phList =
{
    [ID.mob.OKYUPETE - 8] = ID.mob.OKYUPETE,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('nextMove', xi.mobSkill.GIGA_SCREAM_1)
end

entity.onMobMobskillChoose = function(mob, target)
    return mob:getLocalVar('nextMove')
end

-- Alternates between Giga Scream and Dread Dive
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    if skillId == xi.mobSkill.GIGA_SCREAM_1 then
        mob:setLocalVar('nextMove', xi.mobSkill.DREAD_DIVE_1)
    elseif skillId == xi.mobSkill.DREAD_DIVE_1 then
        mob:setLocalVar('nextMove', xi.mobSkill.GIGA_SCREAM_1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 446)
    xi.magian.onMobDeath(mob, player, optParams, set{ 221, 649, 715, 946 })
end

return entity
