-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Wuur the Sandcomber
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.WUUR_THE_SANDCOMBER - 4] = ID.mob.WUUR_THE_SANDCOMBER, -- 14.044 0.494 109.487
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- "Will aggro any player, regardless of level"
    mob:setMod(xi.mod.REGEN, 35) -- "Strong Auto Regen effect (around 30-40 HP)"
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 370)
end

return entity
