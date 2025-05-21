-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Duke Decapod
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobFight = function(mob, target)
    local castTime = mob:getLocalVar('dukeWater')

    if os.time() > castTime then
        mob:castSpell(169, target)
        mob:setLocalVar('dukeWater', os.time() + 10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 255)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 4200))
end

return entity
