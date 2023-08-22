-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Adamantoise
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
    mob:setMod(xi.mod.DMGMAGIC, -3500)
    mob:setMod(xi.mod.DEF, 4120)
    mob:setMod(xi.mod.ATT, 493)
    mob:setMod(xi.mod.POISONRES, 10)
    mob:setMod(xi.mod.SLOWRES, 10)
    mob:setMod(xi.mod.GRAVITYRES, 10)
    mob:setMod(xi.mod.PARALYZERES, 15)
    mob:setMod(xi.mod.BLINDRES, 15)
    mob:setMod(xi.mod.SLEEPRES, 50)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.SILENCERES, 30)

    -- Despawn the ???
    local questionMarks = GetNPCByID(ID.npc.ADAMANTOISE_QM)
    if questionMarks ~= nil then
        questionMarks:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TORTOISE_TORTURER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    local questionMarks = GetNPCByID(ID.npc.ADAMANTOISE_QM)
    if questionMarks ~= nil then
        questionMarks:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
