-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Dragoon
-----------------------------------
mixins =
{
    require('scripts/mixins/follow'),
    require('scripts/mixins/fomor_hate'),
    require('scripts/mixins/fomor_party'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Wyvern')
end

entity.onMobSpawn = function(mob)
    xi.mix.fomorParty.onPartySpawn(mob)

    -- Summon wyvern immediately on spawn
    mob:useMobAbility(xi.jsa.CALL_WYVERN)
end

entity.onMobRoam = function(mob)
    xi.mix.fomorParty.onPartyRoam(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.mix.fomorParty.onPartyDeath(mob)
    end
end

return entity
