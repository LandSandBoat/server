-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Archaic Chariot
-- HP 30500
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
mixins = { require('scripts/mixins/families/chariot') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    if mob:getID() == ID.mob.ARCHAIC_CHARIOT[3] then
        mob:setMobMod(xi.mobMod.SUBLINK, 0)
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    else
        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
        mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    end
end

entity.onMobEngage = function(mob, target)
    local instance = mob:getInstance()

    if instance then
        if instance:getStage() == 6 and mob:getLocalVar('spawnedGears') == 0 then
            mob:setLocalVar('spawnedGears', 1)
            xi.salvage.spawnGroup(instance, utils.slice(ID.mob.ARCHAIC_GEARS, 33, 42))
            xi.salvage.spawnGroup(instance, utils.slice(ID.mob.ARCHAIC_GEAR, 21, 22))
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            if instance:getStage() == 6 then
                instance:setLocalVar('6th Door', instance:getLocalVar('6th Door') + 1)
            end
        end
    end
end

return entity
