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
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice_ziz.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice_ziz.onMobWeaponSkill(mob, target, skill)
end

return entity
