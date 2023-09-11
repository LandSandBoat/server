-----------------------------------
-- Area: Qulun Dome
--   NM: Za'Dha Adamantking
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Qulun_Dome/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 40)
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.QUADAV_KING_ENGAGE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW, { power = 3000 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ADAMANTKING_USURPER)
    if optParams.isKiller then
        mob:showText(mob, ID.text.QUADAV_KING_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    -- reset hqnm system back to the nm placeholder
    local nqID = ID.mob.DIAMOND_QUADAV
    local nqMob = GetMobByID(nqID)
    SetServerVariable("[POP]Za_Dha_Adamantking", os.time() + 259200) -- 3 days
    SetServerVariable("[PH]Za_Dha_Adamantking", 0)
    SetServerVariable("[POPNUM]Za_Dha_Adamantking", 0)
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(nqID, false)
    xi.mob.nmTODPersist(nqMob, math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
