-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Carthi
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local headstone = GetNPCByID(ID.npc.CERMET_HEADSTONE)
        local tipha     = GetMobByID(ID.mob.TIPHA)
        if
            headstone and
            tipha and
            tipha:isDead()
        then
            headstone:setLocalVar('cooldown', GetSystemTime() + 900)
        end
    end
end

return entity
