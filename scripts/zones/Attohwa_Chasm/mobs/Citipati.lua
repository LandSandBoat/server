-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Citipati
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    -- Since DisallowRespawn() doesn't care about SPAWNTYPE_NIGHT we have to get creative
    local totd = VanadielTOTD()
    if totd ~= xi.time.NIGHT and totd ~= xi.time.MIDNIGHT then
        mob:setLocalVar('doNotInvokeCooldown', 1)
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 278)
end

return entity
