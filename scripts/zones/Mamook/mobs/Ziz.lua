-----------------------------------
-- Area: Mamook
--  Mob: Ziz
-- Note: PH for Zizzy Zillah
-----------------------------------
mixins =
{
    require('scripts/mixins/sleep_at_night'),
    require('scripts/mixins/families/cockatrice_ziz')
}
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice_ziz.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice_ziz.onMobWeaponSkill(mob, target, skill)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ZIZZY_ZILLAH, 5, 3600) -- 1 hour
end

return entity
