-----------------------------------
-- Area: Cape Teriggan
--   NM: Axesarion the Wanderer
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    -- Dark sleep isnt an immunity, its a resistance rank 11 resist. It can potentially be immunobroken.
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local headstone = GetNPCByID(ID.npc.CERMET_HEADSTONE)
        if headstone then
            headstone:setLocalVar('cooldown', GetSystemTime() + 900)
        end
    end
end

return entity
