-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Weaver
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}
local nmPopChance = 50

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 648, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT then
        if math.random(1, 100) <= nmPopChance then
            local mobId = mob:getID()
            local nmId = ID.mob.MAGICKED_BONES_PH_DAGGER[mobId]
            if nmId then
                local skele = GetMobByID(nmId)
                local respawnTime = mob:getRespawnTime()
                DisallowRespawn(mobId, true)
                mob:timer(respawnTime, function()
                    skele:setModelId(1096) --Dagger Skeleton Model ID
                    skele:spawn()
                end)
            end
        end
    end
end

return entity
