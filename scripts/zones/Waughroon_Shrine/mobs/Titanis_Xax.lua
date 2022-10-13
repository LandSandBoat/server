-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Xax
-- KSNM: Prehistoric Pigeons
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    local id = mob:getID()
    if GetMobByID(id + 1):isAlive() then
        GetMobByID(id + 1):addMod(xi.mod.DELAY, 1000)
    end
    for i = 1, 2 do
        if GetMobByID(id - i):isAlive() then
            GetMobByID(id - i):addMod(xi.mod.DELAY, 1000)
        end
    end
end

return entity
