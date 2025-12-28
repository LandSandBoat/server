-----------------------------------
-- Area: Konschtat Highlands
--   NM: Ghillie Dhu
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  387.000, y =  -8.873, z =  -338.999 },
    { x =  403.000, y =  -9.000, z =  -362.000 },
    { x =  400.000, y =  -8.000, z =  -342.000 },
    { x =  349.000, y = -16.000, z =  -444.000 },
    { x =  401.000, y =  -9.000, z =  -369.000 },
    { x =  393.000, y =  -9.000, z =  -359.000 },
    { x =  381.000, y = -10.000, z =  -331.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60~70 min repop.
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    -- For its TP drain melee.
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobRoam = function(mob)
    -- Fairly sure he shouldn't be storing up max TP while idle.
    if mob:getMod(xi.mod.REGAIN) ~= 0 then
        mob:setMod(xi.mod.REGAIN, 0)
    end
end

entity.onMobFight = function(mob, target)
    -- Guesstimating the regain scales from 1-100,
    -- nobody has the excact values but it scales with HP.
    local tp = (100 - mob:getHPP()) * 0.5
    if mob:getMod(xi.mod.REGAIN) ~= utils.clamp(tp, 1, 100) then
        mob:setMod(xi.mod.REGAIN, utils.clamp(tp, 1, 100))
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { power = math.random(10, 30) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 204)
    -- I think he still counts for the FoV page? Most NM's do not though.
    xi.regime.checkRegime(player, mob, 81, 1, xi.regime.type.FIELDS)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60~70 min repop.
end

return entity
