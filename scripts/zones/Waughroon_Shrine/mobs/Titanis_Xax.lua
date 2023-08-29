-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Xax
-- KSNM: Prehistoric Pigeons
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
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
end

return entity
