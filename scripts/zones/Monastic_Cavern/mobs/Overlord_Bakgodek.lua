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
end

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.OVERLORD_OVERTHROWER)
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
