-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: TeZha Ironclad
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TEZHA_IRONCLAD - 8] = ID.mob.TEZHA_IRONCLAD, -- Vanguard_Defender
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
