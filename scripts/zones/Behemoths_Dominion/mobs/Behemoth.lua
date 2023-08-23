-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: Behemoth
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    mob:addMod(xi.mod.SLEEPRES, 90)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:setMod(xi.mod.MDEF, 20)
    mob:setMod(xi.mod.EVA, 315)
    mob:setMod(xi.mod.ATT, 256)
    mob:setMod(xi.mod.POISONRES, 10)
    mob:setMod(xi.mod.SLOWRES, 10)
    mob:setMod(xi.mod.GRAVITYRES, 10)
    mob:setMod(xi.mod.PARALYZERES, 15)
    mob:setMod(xi.mod.BLINDRES, 15)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.SILENCERES, 100)

    -- Despawn the ???
    local questionMarks = GetNPCByID(ID.npc.BEHEMOTH_QM)
    if questionMarks ~= nil then
        questionMarks:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onMobFight = function(mob, target)
    local drawInTableNorth =
    {
        condition1 = target:getXPos() > -180 and target:getZPos() > 53,
        position   = { -182.19, -19.83, 58.34, target:getRotPos() },
    }
    local drawInTableSouth =
    {
        condition1 = target:getXPos() > -230 and target:getZPos() < 5,
        position   = { -235.35, -20.01, -4.47, target:getRotPos() },
    }

    utils.arenaDrawIn(mob, target, drawInTableNorth)
    utils.arenaDrawIn(mob, target, drawInTableSouth)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEHEMOTHS_BANE)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    local questionMarks = GetNPCByID(ID.npc.BEHEMOTH_QM)
    if questionMarks ~= nil then
        questionMarks:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
