-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Draconic Draugar (DRG)
-----------------------------------
mixins =
{
    -- require("scripts/mixins/master_instanced"),
    require("scripts/mixins/job_special"),
}
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPEVA_DARK, 9999)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    local firstCall = isKiller or noKiller
    if firstCall then
        local instance = mob:getInstance()
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
