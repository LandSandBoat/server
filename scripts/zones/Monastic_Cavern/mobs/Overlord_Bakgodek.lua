-----------------------------------
-- Area: Monastic Cavern
--  Mob: Overlord Bakgodek
-- TODO: messages should be zone-wide
-----------------------------------
local ID = require("scripts/zones/Monastic_Cavern/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.ORC_KING_ENGAGE)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.SLEEPRES, 90)
    mob:setMod(tpz.mod.PARALYZERES, 75)
    mob:setMod(tpz.mod.SILENCERES, 75)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TP_DRAIN, {chance = 35, power = math.random(95, 135)})
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.OVERLORD_OVERTHROWER)
    if isKiller then
        mob:showText(mob, ID.text.ORC_KING_DEATH)
    end
end

entity.onMobDespawn = function(mob)
    -- reset hqnm system back to the nm placeholder
    local nqId = mob:getID() - 1
    SetServerVariable("[POP]Overlord_Bakgodek", os.time() + 259200) -- 3 days
    SetServerVariable("[PH]Overlord_Bakgodek", 0)
    DisallowRespawn(mob:getID(), true)
    DisallowRespawn(nqId, false)
    UpdateNMSpawnPoint(nqId)
    GetMobByID(nqId):setRespawnTime(math.random(75600, 86400))
end

return entity
