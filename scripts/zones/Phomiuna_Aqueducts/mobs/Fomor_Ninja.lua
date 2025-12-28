-----------------------------------
-- Area: Phomiuna_Aqueducts
--  Mob: Fomor Ninja
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

entity.onMobSpawn = function(mob)
    xi.mix.fomorParty.onPartySpawn(mob)
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
