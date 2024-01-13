require("scripts/globals/utils")
-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Magicked Bones
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local weaver_id = 17563669
local thug_id = 17563668

local dagger_id = 17563671
local club_id = 17563670

entity.onMobDespawn = function(mob)
    local mob_id = mob:getID()
    if mob_id == dagger_id then
        DisallowRespawn(weaver_id, false)
        GetMobByID(weaver_id):setRespawnTime(GetMobRespawnTime(weaver_id))
    elseif mob_id == club_id then
        DisallowRespawn(thug_id, false)
        GetMobByID(thug_id):setRespawnTime(GetMobRespawnTime(thug_id))
    end
end
return entity
