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
        local hqId        = xi.mob.OVERLORD_BAKGODEK
        local timeOfDeath = GetServerVariable("[POP]Overlord_Bakgodek")
        local kills       = GetServerVariable("[PH]Overlord_Bakgodek")
        SetServerVariable("[POPNUM]Overlord_Bakgodek", math.random(kills, 4))
        local popNow      = GetServerVariable("[POPNUM]Overlord_Bakgodek") == 4

        if os.time() > timeOfDeath and popNow then
            DisallowRespawn(nqId, true)
            DisallowRespawn(hqId, false)
            xi.mob.nmTODPersist(GetMobByID(hqId), math.random(75600, 86400))
        elseif os.time() > timeOfDeath then -- Track NQ kills after 3 days
            xi.mob.nmTODPersist(GetMobByID(nqId), math.random(75600, 86400))
            SetServerVariable("[PH]Overlord_Bakgodek", kills + 1)
        else
            xi.mob.nmTODPersist(GetMobByID(nqId), math.random(75600, 86400))
        end
    end
end

return entity
