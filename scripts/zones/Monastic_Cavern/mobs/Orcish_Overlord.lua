-----------------------------------
-- Area: Monastic Cavern
--   NM: Orcish Overlord
-- Note: PH for Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.UNDERSTANDING_OVERLORD_OFFSET then
        mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    end

    if mob:getID() == ID.mob.ORCISH_OVERLORD then
        mob:addMod(xi.mod.DOUBLE_ATTACK, 20)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.ORCISH_OVERLORD_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.ORCISH_OVERLORD_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local nqId = mob:getID()

    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.ORCISH_OVERLORD then
        local hqId        = mob:getID() + 1
        local timeOfDeath = GetServerVariable("[POP]Overlord_Bakgodek")
        local kills       = GetServerVariable("[PH]Overlord_Bakgodek")
        local popNow      = math.random(1, 5) == 3 or kills > 6

        if os.time() > timeOfDeath and popNow then
            DisallowRespawn(nqId, true)
            DisallowRespawn(hqId, false)
            UpdateNMSpawnPoint(hqId)
            GetMobByID(hqId):setRespawnTime(math.random(75600, 86400))
        else
            UpdateNMSpawnPoint(nqId)
            mob:setRespawnTime(math.random(75600, 86400))
            SetServerVariable("[PH]Overlord_Bakgodek", kills + 1)
        end
    end
end

return entity
