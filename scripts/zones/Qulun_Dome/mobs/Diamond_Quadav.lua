-----------------------------------
-- Area: Qulun_Dome
--   NM: Diamond Quadav
-- Note: PH for Za Dha Adamantking PH
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/Qulun_Dome/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- the quest version of this NM doesn't drop gil
    if mob:getID() >= ID.mob.AFFABLE_ADAMANTKING_OFFSET then
        mob:setMobMod(xi.mobMod.GIL_MAX, -1)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.DIAMOND_QUADAV_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.DIAMOND_QUADAV_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local nqID = mob:getID()

    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqID == ID.mob.DIAMOND_QUADAV then
        local hqID        = ID.mob.ZADHA_ADAMANTKING
        local timeOfDeath = GetServerVariable("[POP]Za_Dha_Adamantking")
        local kills       = GetServerVariable("[PH]Za_Dha_Adamantking")
        SetServerVariable("[POPNUM]Za_Dha_Adamantking", math.random(kills, 4))
        local popNow      = GetServerVariable("[POPNUM]Za_Dha_Adamantking") == 4

        if os.time() > timeOfDeath and popNow then
            DisallowRespawn(nqID, true)
            DisallowRespawn(hqID, false)
            xi.mob.nmTODPersist(GetMobByID(hqID), math.random(75600, 86400)) -- 21 to 24 hours
        elseif os.time() > timeOfDeath then -- Track NQ kills after 3 days
            xi.mob.nmTODPersist(GetMobByID(nqID), math.random(75600, 86400))
            SetServerVariable("[PH]Za_Dha_Adamantking", kills + 1)
        else
            xi.mob.nmTODPersist(GetMobByID(nqID), math.random(75600, 86400))
        end
    end
end

return entity
