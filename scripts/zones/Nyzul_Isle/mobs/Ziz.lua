-----------------------------------
--  MOB: Ziz
-- Area: Nyzul Isle
-----------------------------------
mixins =
{
    require('scripts/mixins/sleep_at_night'),
    require('scripts/mixins/families/cockatrice_ziz')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.nyzul.specifiedEnemySet(mob)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.cockatrice_ziz.onMobMobskillChoose(mob, target)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    return xi.mix.cockatrice_ziz.onMobWeaponSkill(mob, target, skill)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedEnemyKill(mob)
    end
end

return entity
