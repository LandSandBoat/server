require("scripts/globals/utils")
-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Magicked Bones
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
local entity = {}

local weaverId = 17563669
local thugId = 17563668

local daggerId = 17563671
local clubId = 17563670

entity.onMobDespawn = function(mob)
    local mobId = mob:getID()
    if mobId == daggerId then
        DisallowRespawn(weaverId, false)
        GetMobByID(weaverId):setRespawnTime(GetMobRespawnTime(weaverId))
    elseif mobId == clubId then
        DisallowRespawn(thugId, false)
        GetMobByID(thugId):setRespawnTime(GetMobRespawnTime(thugId))
    end
end

return entity
