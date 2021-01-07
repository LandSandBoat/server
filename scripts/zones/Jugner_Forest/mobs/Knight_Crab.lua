-----------------------------------
-- Area: Jugner Forest
--  Mob: Knight Crab
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    -- If respawn and variable is not 0, then it respawned before someone killed all 10 crabs
    local KingArthro = GetMobByID(ID.mob.KING_ARTHRO)

    if KingArthro:getLocalVar("[POP]King_Arthro") > 0 then
        KingArthro:setLocalVar("[POP]King_Arthro", KingArthro:getLocalVar("[POP]King_Arthro")  - 1)
    end

    -- 5 minute rage timer (ffxiah says 5, ffxiclopedia says 5-10, bg doesn't say at all)
    mob:setLocalVar("[rage]timer", 300)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local KingArthro = GetMobByID(ID.mob.KING_ARTHRO)

    KingArthro:setLocalVar("[POP]King_Arthro", KingArthro:getLocalVar("[POP]King_Arthro") + 1)

    if KingArthro:getLocalVar("[POP]King_Arthro") == 10 then
        KingArthro:setLocalVar("[POP]King_Arthro", 0)
        SpawnMob(ID.mob.KING_ARTHRO) -- Pop King Arthro !
    end
end

return entity
