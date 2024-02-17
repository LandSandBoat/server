-----------------------------------
-- Area: Monastic Cavern
--  Mob: Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = zones[xi.zone.MONASTIC_CAVERN]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.SLEEP_MEVA, 90)
    mob:setMod(xi.mod.PARALYZE_MEVA, 75)
    mob:setMod(xi.mod.SILENCE_MEVA, 75)
end

entity.onMobEngage = function(mob, target)
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
    local nqId = mob:getID() - 1
    SetServerVariable('[POP]Overlord_Bakgodek', os.time() + 259200) -- 3 days
    SetServerVariable('[PH]Overlord_Bakgodek', 0)
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(nqId, false)
    UpdateNMSpawnPoint(nqId)
    GetMobByID(nqId):setRespawnTime(math.random(75600, 86400))
end

return entity
