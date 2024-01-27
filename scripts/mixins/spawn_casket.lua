-- Casket Mixins
require('scripts/globals/caskets')
require('scripts/globals/mixins')

g_mixins = g_mixins or {}

-----------------------------------
-- Casket zone check
-----------------------------------
g_mixins.spawn_casket = function(casketMob)
    casketMob:addListener('DEATH', 'DEATH_SPAWN_CASKET', function(mob, player, isKiller)
        local mobPos = mob:getPos()

        if player then
            if mob:getMaster() ~= nil then
                local master = mob:getMaster()
                if master:isMob() then -- sanity check, ensuring the mob killed is not a player's pet.
                    xi.caskets.spawnCasket(player, mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                end
            else
                xi.caskets.spawnCasket(player, mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            end
        end
    end)
end

return g_mixins.spawn_casket
