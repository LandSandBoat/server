-----------------------------------
-- Area: Castle Oztroja
--   NM: Tzee Xicu the Manifest
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.YAGUDO_KING_ENGAGE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = 60 })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.DEITY_DEBUNKER)
    if optParams.isKiller then
        mob:showText(mob, ID.text.YAGUDO_KING_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    -- reset hqnm system back to the nm placeholder
    local nqId = mob:getID() - 3
    SetServerVariable("[POP]Tzee_Xicu_the_Manifest", os.time() + 259200) -- 3 days
    SetServerVariable("[PH]Tzee_Xicu_the_Manifest", 0)
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(nqId, false)
    UpdateNMSpawnPoint(nqId)
    GetMobByID(nqId):setRespawnTime(math.random(75600, 86400))
end

return entity
