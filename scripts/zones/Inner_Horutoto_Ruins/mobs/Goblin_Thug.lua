-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Thug
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}
local nmPopChance = 50

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 647, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT then
        if math.random(1, 100) <= nmPopChance then
            local mobId = mob:getID()
            local nmId = ID.mob.MAGICKED_BONES_PH_CLUB[mobId]
            if nmId then
                local skele = GetMobByID(nmId)
                local respawnTime = mob:getRespawnTime()
                DisallowRespawn(mobId, true)
                mob:timer(respawnTime, function()
                    skele:setModelId(573) --Club Skeleton Model ID
                    skele:spawn()
                end)
            end
        end
    end
end

return entity
