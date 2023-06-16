-----------------------------------
-- Area: Dragons Aery
--  HNM: Nidhogg
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
    mob:setMod(xi.mod.ATT, 499)
    mob:setMod(xi.mod.ACC, 444)
    mob:setMod(xi.mod.EVA, 341)
    mob:setMod(xi.mod.POISONRES, 10)
    mob:setMod(xi.mod.SLOWRES, 10)
    mob:setMod(xi.mod.GRAVITYRES, 10)
    mob:setMod(xi.mod.PARALYZERES, 15)
    mob:setMod(xi.mod.BLINDRES, 15)
    mob:setMod(xi.mod.SLEEPRES, 50)
    mob:setMod(xi.mod.SLEEPRESBUILD, 50)
    mob:setMod(xi.mod.LULLABYRESBUILD, 50)
    mob:setMod(xi.mod.STUNRES, 100)
    mob:setMod(xi.mod.SILENCERES, 100)

    -- Despawn the ???
    local questionMarks = GetNPCByID(ID.npc.FAFNIR_QM)
    if questionMarks ~= nil then
        questionMarks:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onMobFight = function(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
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

    if twohourTime == 0 then
        mob:setLocalVar("twohourTime", math.random(30, 90))
    end

    if battletime >= twohourTime then
        mob:useMobAbility(1053) -- Legitimately captured super_buff ID
        mob:setLocalVar("twohourTime", battletime + math.random(60, 120))
    end

    utils.arenaDrawIn(mob, target, drawInTableNortheast)
    utils.arenaDrawIn(mob, target, drawInTableWest)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.NIDHOGG_SLAYER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    local questionMarks = GetNPCByID(ID.npc.FAFNIR_QM)
    if questionMarks ~= nil then
        questionMarks:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
