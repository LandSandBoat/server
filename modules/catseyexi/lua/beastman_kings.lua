-----------------------------------------------------
-- Areas: Monastic_Cavern/Castle_Oztroja/Qulun_Dome
-- Make HQ NM's pop on despawn of placeholders
-----------------------------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------
local m = Module:new("beastman_kings")

m:addOverride("xi.zones.Monastic_Cavern.mobs.Orcish_Overlord.onMobDespawn", function(mob)
    local ID = require("scripts/zones/Monastic_Cavern/IDs")
	local nqId = mob:getID()

    player:PrintToPlayer("Please stand by to see if HQ pops after despawn...")
    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.ORCISH_OVERLORD then
        local hqId        = mob:getID() + 1
        local popNow      = math.random(1, 3) == 3

        if popNow then
            SpawnMob(hqId)
        end
    end
end)

m:addOverride("xi.zones.Castle_Oztroja.mobs.Yagudo_Avatar.onMobDespawn", function(mob)
    local ID = require("scripts/zones/Castle_Oztroja/IDs")
    local nqId = mob:getID()

    player:PrintToPlayer("Please stand by to see if HQ pops after despawn...")
    if nqId == ID.mob.YAGUDO_AVATAR then
        local hqId        = mob:getID() + 3
        local popNow      = math.random(1, 3) == 3

        if popNow then
            SpawnMob(hqId)
        end
    end
end)

m:addOverride("xi.zones.Qulun_Dome.mobs.Diamond_Quadav.onMobDespawn", function(mob)
    local ID = require("scripts/zones/Qulun_Dome/IDs")
	local nqId = mob:getID()

    player:PrintToPlayer("Please stand by to see if HQ pops after despawn...")
    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.DIAMOND_QUADAV then
        local hqId        = mob:getID() + 1
        local popNow      = math.random(1, 3) == 3

        if popNow then
            SpawnMob(hqId)
        end
    end
end)

return m 