-----------------------------------
-- Area: Monastic Cavern
--  Mob: Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.SLEEPRES, 90)
    mob:setMod(xi.mod.PARALYZERES, 75)
    mob:setMod(xi.mod.SILENCERES, 75)
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.ORC_KING_ENGAGE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 35, power = math.random(95, 135) })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.OVERLORD_OVERTHROWER)
    if optParams.isKiller then
        mob:showText(mob, ID.text.ORC_KING_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    -- reset hqnm system back to the nm placeholder
    local nqID = mob:getID() - 1
    SetServerVariable("[POP]Overlord_Bakgodek", os.time() + 259200) -- 3 days
    SetServerVariable("[PH]Overlord_Bakgodek", 0)
    SetServerVariable("[POPNUM]Overlord_Bakgodek", 0)
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(nqID, false)
    xi.mob.nmTODPersist(GetMobByID(nqID), math.random(75600, 86400))
end

return entity
