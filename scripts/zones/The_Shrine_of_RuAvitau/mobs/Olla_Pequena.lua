-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Pequena
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance  = 25,
        element = xi.element.DARK,
    }

    return xi.combat.action.executeAdditionalDispel(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        SpawnMob(mob:getID() + 1):updateClaim(player)
    end
end

entity.onMobDespawn = function(mob)
    if not GetMobByID(mob:getID() + 1):isSpawned() then -- if this Pequena despawns and Media is not alive, it would be because it despawned outside of being killed.
        GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
