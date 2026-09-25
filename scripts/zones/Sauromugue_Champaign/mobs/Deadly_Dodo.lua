-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Deadly Dodo
-----------------------------------
mixins = { require('scripts/mixins/families/cockatrice') }
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DEADLY_DODO - 2] = ID.mob.DEADLY_DODO, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice.onMobWeaponSkill(mob, target, skill)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 272)
    xi.magian.onMobDeath(mob, player, optParams, set{ 580 })
end

entity.onMobDespawn = function(mob)
end

return entity
