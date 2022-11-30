-----------------------------------
-- Area: Castle Oztroja (151)
--   NM: Yagudo Avatar
-- Note: PH for Tzee Xicu the Manifest
-- TODO: messages should be zone-wide
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/status")
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
    local nqID = mob:getID()

    if nqID == ID.mob.YAGUDO_AVATAR then
        local hqMob       = GetMobByID(ID.mobs.TZEE_XICU_THE_MANIFEST)
        local hqID        = hqMob():getID()
        local timeOfDeath = GetServerVariable("[POP]Tzee_Xicu_the_Manifest")
        local kills       = GetServerVariable("[PH]Tzee_Xicu_the_Manifest")
        local popNow      = (math.random(1, 5) == 3 or kills > 6)

        if os.time() > timeOfDeath and popNow then
            DisallowRespawn(nqID, true)
            DisallowRespawn(hqID, false)
            xi.mob.nmTODPersist(hqMob, math.random(75600, 86400)) -- 21 to 24 hours
        else
            xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
            SetServerVariable("[PH]Tzee_Xicu_the_Manifest", kills + 1)
        end
    end
end

return entity
