-----------------------------------
-- Area: Behemoths Dominion
--   NM: Ancient Weapon
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 102, 2, xi.regime.type.FIELDS)

    if optParams.isKiller or optParams.noKiller then
        local headstone       = GetNPCByID(ID.npc.CERMET_HEADSTONE)
        local legendaryWeapon = GetMobByID(ID.mob.LEGENDARY_WEAPON)

        if
            headstone and
            legendaryWeapon and
            legendaryWeapon:isDead()
        then
            headstone:setLocalVar('cooldown', GetSystemTime() + 900)
        end
    end
end

return entity
