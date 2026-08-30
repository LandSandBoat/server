-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Ziz
-----------------------------------
mixins =
{
    require('scripts/mixins/sleep_at_night'),
    require('scripts/mixins/families/cockatrice_ziz')
}
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setDelay(750)
    mob:setMod(xi.mod.ATT, 100)
    mob:setMod(xi.mod.MAIN_DMG_RATING, -15)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice_ziz.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice_ziz.onMobWeaponSkill(mob, target, skill)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            if xi.salvage.groupKilled(instance, ID.mob.ZIZ) then
                SpawnMob(ID.mob.POROGGO_GENT[2], instance):setDropID(2016)
            end
        end
    end
end

return entity
