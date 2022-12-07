-----------------------------------
-- Area: Dragons Aery
--  HNM: Fafnir
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN_CUSTOM_RANGE, 20)
    mob:setMobMod(xi.mobMod.DRAW_IN_FRONT, 1)
    mob:setMod(xi.mod.ATT, 489)

    -- Despawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobFight = function(mob, target)
    local drawInTableNortheast =
    {
        condition1 = target:getXPos() > 95 and target:getZPos() > 56,
        position   = { 94.2809, 6.6438, 54.0863, target:getRotPos() },
    }
    local drawInTableWest =
    {
        condition1 = target:getXPos() < 60 and target:getZPos() < 23,
        position   = { 65.5966, 7.7105, 26.2332, target:getRotPos() },
    }

    utils.arenaDrawIn(mob, target, drawInTableNortheast)
    utils.arenaDrawIn(mob, target, drawInTableWest)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.FAFNIR_SLAYER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.FAFNIR_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
