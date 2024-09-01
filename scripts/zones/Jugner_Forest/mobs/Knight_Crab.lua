-----------------------------------
-- Area: Jugner Forest
--  Mob: Knight Crab
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- 5 minute rage timer (ffxiah says 5, ffxiclopedia says 5-10, bg doesn't say at all)
    xi.applyMixins(mob, mixins.rage, { rageTimer = utils.minutes(5) })
end

entity.onMobSpawn = function(mob)
    -- If respawn and variable is not 0, then it respawned before someone killed all 10 crabs
    local kingArthro = GetMobByID(ID.mob.KING_ARTHRO)
    if kingArthro and kingArthro:getLocalVar('[POP]King_Arthro') > 0 then
        kingArthro:setLocalVar('[POP]King_Arthro', kingArthro:getLocalVar('[POP]King_Arthro')  - 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local kingArthro = GetMobByID(ID.mob.KING_ARTHRO)

    if not kingArthro then
        return
    end

    kingArthro:setLocalVar('[POP]King_Arthro', kingArthro:getLocalVar('[POP]King_Arthro') + 1)

    if kingArthro:getLocalVar('[POP]King_Arthro') == 10 then
        kingArthro:setLocalVar('[POP]King_Arthro', 0)
        SpawnMob(ID.mob.KING_ARTHRO) -- Pop King Arthro !
    end
end

return entity
