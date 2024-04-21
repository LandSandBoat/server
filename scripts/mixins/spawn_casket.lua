-- Casket Mixins
require('scripts/globals/caskets')
require('scripts/globals/mixins')

xi = xi or {}
xi.mixins = xi.mixins or {}

local mixin = {}

-----------------------------------
-- Casket zone check
-----------------------------------
mixin.spawn_casket = function(casketMob)
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

return mixin
