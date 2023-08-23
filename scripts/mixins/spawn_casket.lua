-- Casket Mixins
require("scripts/globals/caskets")
require("scripts/globals/mixins")

g_mixins = g_mixins or {}

-----------------------------------
-- Casket zone check
-----------------------------------
g_mixins.spawn_casket = function(casketMob)
    casketMob:addListener("DEATH", "DEATH_SPAWN_CASKET", function(mob, player, optParams)
        local mobPos = mob:getPos()

        if player then
            if mob:getMaster() ~= nil then
                local master = mob:getMaster()
                if master:isMob() then -- sanity check, ensuring the mob killed is not a player's pet.
                    if
                        mob:getZone():getType() < xi.zoneType.DUNGEON and
                        xi.settings.main.ENABLE_WOTG == 1
                    then
                        xi.caskets.spawnCasket(player, mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                    elseif
                        mob:getZone():getType() == xi.zoneType.DUNGEON and
                        xi.settings.main.ENABLE_ABYSSEA == 1
                    then
                        xi.caskets.spawnCasket(player, mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                    end
                end
            else
                if
                    mob:getZone():getType() < xi.zoneType.DUNGEON and
                    xi.settings.main.ENABLE_WOTG == 1
                then
                    xi.caskets.spawnCasket(player, mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                elseif
                    mob:getZone():getType() == xi.zoneType.DUNGEON and
                    xi.settings.main.ENABLE_ABYSSEA == 1
                then
                    xi.caskets.spawnCasket(player, mob, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                end
            end
        end
    end)
end

return g_mixins.spawn_casket
