-----------------------------------
-- Area: QuBia_Arena
--  Mob: Warlord Rojgnoj
-- Mission 9-2 SANDO
-----------------------------------
local global = require("scripts/zones/QuBia_Arena/Globals")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(tpz.mod.SLEEPRES, 50)
end

entity.onMobSpawn = function(mob)
    local battlefield = mob:getBattlefield()
    if battlefield and global.phaseChangeReady(battlefield) then
        battlefield:setLocalVar("phaseChange", 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
