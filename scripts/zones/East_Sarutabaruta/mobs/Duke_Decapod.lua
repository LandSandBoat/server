-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Duke Decapod
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setRespawnTime(math.randomInt(3600, 4200)) -- When server restarts, reset timer
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobFight = function(mob, target)
    local castTime = mob:getLocalVar('dukeWater')

    if GetSystemTime() > castTime then
        mob:castSpell(169, target)
        mob:setLocalVar('dukeWater', GetSystemTime() + 10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 255)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(3600, 4200))
end

return entity
