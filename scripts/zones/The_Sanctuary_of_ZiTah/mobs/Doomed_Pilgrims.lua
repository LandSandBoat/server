-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Doomed Pilgrims
-----------------------------------
local ID = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar('cooldown', os.time() + 900)
    end
end

return entity
