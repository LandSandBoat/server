-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Delicieuse Delphine
-- https://www.bg-wiki.com/ffxi/Delicieuse_Delphine
-- Only uses Impale, and does it in threes
-- TODO allow deaggro based on distance (core CMobEntity::CanDeaggro() forces NM and Battlefield mobs to never stop chasing)
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -515.400, y = -23.780, z = -453.510 }
}

entity.phList =
{
    [ID.mob.DELICIEUSE_DELPHINE - 1] = ID.mob.DELICIEUSE_DELPHINE, -- -484.535 -23.756 -467.462
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 50)
    mob:addMod(xi.mod.MOVE_SPEED_STACKABLE, 18)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobMobskillChoose = function(mob, target)
    mob:setLocalVar('impaleCount', 2)

    return 316 -- Impale
end

entity.onMobWeaponSkill = function(target, mob, skill, action)
    if mob:getLocalVar('impaleCount') > 0 then
        mob:setLocalVar('impaleCount', mob:getLocalVar('impaleCount') - 1)
        mob:useMobAbility(skill:getID())
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { chance = 50, duration = math.random(5, 30) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 513)
end

return entity
