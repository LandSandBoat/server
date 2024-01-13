-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Thug
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}
local nm_pop_chance = 50

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 647, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT then
        if math.random(1, 100) <= nm_pop_chance then
            local mob_id = mob:getID()
            local nmID = ID.mob.MAGICKED_BONES_PH_CLUB[mob_id]
            if nmID then
                local skele = GetMobByID(nmID)
                local respawn_time = mob:getRespawnTime()
                DisallowRespawn(mob_id, true)
                mob:timer(respawn_time, function()
                    skele:setModelId(573) --Club Skeleton Model ID
                    skele:spawn()
                end)
            end
        end
    end
end

return entity
