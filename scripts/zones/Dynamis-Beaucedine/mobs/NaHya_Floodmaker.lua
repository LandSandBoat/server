-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: NaHya Floodmaker
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NAHYA_FLOODMAKER - 5] = ID.mob.NAHYA_FLOODMAKER, -- Vanguard_Protector
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
