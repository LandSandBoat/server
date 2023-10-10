-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yagudo Avatar
-- Note: PH for Tzee Xicu the Manifest
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.YAGUDO_AVATAR_ENGAGE)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.YAGUDO_AVATAR_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    local nqId = mob:getID()

    -- the quest version of this NM doesn't respawn or count toward hq nm
    if nqId == ID.mob.YAGUDO_AVATAR then
        local hqId        = ID.mob.TZEE_XICU_THE_MANIFEST
        local timeOfDeath = GetServerVariable("[POP]Tzee_Xicu_the_Manifest")
        local kills       = GetServerVariable("[PH]Tzee_Xicu_the_Manifest")
        SetServerVariable("[POPNUM]Tzee_Xicu_the_Manifest", math.random(kills, 4))
        local popNow      = GetServerVariable("[POPNUM]Tzee_Xicu_the_Manifest") == 4

        if os.time() > timeOfDeath and popNow then
            DisallowRespawn(nqId, true)
            DisallowRespawn(hqId, false)
            xi.mob.nmTODPersist(GetMobByID(hqId), math.random(75600, 86400))
        elseif os.time() > timeOfDeath then -- Track NQ kills after 3 days
            xi.mob.nmTODPersist(GetMobByID(nqId), math.random(75600, 86400))
            SetServerVariable("[PH]Tzee_Xicu_the_Manifest", kills + 1)
        else
            xi.mob.nmTODPersist(GetMobByID(nqId), math.random(75600, 86400))
        end
    end
end

return entity
