-----------------------------------
-- Area: Dragons Aery
--  HNM: Fafnir
-----------------------------------
local ID = zones[xi.zone.DRAGONS_AERY]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, mixins.rage, { rageTimer = utils.minutes(60) })
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 50) -- Level 90 + 50 = 140 Base Weapon Damage

    -- Despawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.FAFNIR_SLAYER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
