-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Feeler Antlion
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
local attohwaChasmGlobal = require('scripts/zones/Attohwa_Chasm/globals')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 40) -- Don't know exact value
    mob:addMod(xi.mod.REGEN, 30)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('SAND_BLAST', 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if attohwaChasmGlobal.canStartFeelerQMTimer() then
        GetNPCByID(ID.npc.QM_FEELER_ANTLION):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
