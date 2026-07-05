-----------------------------------
-- Area: Sacrarium
--  Mob: Fomor's Elemental
-- Lobais' pet
-----------------------------------
require('scripts/globals/pets/summon')
-----------------------------------
---@type TMobEntity
local entity = {}

local possibleSpirits =
{
    xi.pets.summon.type.DARK_SPIRIT,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    xi.pets.summon.setupSummon(mob, possibleSpirits)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local master = mob:getMaster()

        if not master then
            return
        end

        master:setLocalVar('petSummonTime', GetSystemTime() + math.randomInt(10, 15))
    end
end

return entity
