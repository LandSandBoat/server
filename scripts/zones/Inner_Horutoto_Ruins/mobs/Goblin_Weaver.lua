require("scripts/globals/utils")
-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Weaver
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}
local nm_pop_chance = 50

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 648, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local totd = VanadielTOTD()
    if totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT then
        if math.random(1, 100) <= nm_pop_chance then
            local mob_id = mob:getID()
            local nmID = ID.mob.MAGICKED_BONES_PH_DAGGER[mob_id]
            if nmID then
                local skele = GetMobByID(nmID)
                local respawn_time = mob:getRespawnTime()
                DisallowRespawn(mob_id, true)
                mob:timer(respawn_time, function()
                    skele:setModelId(1096) --Dagger Skeleton Model ID
                    skele:spawn()
                end)
            end
        end
    end
end
return entity
