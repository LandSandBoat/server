-----------------------------------
-- Area: Zhayolm Remnants
-- MOB: Jakko
-- Notes: spawns with random hate target
-----------------------------------
mixins = { require('scripts/mixins/families/imp') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    mob:addImmunity(xi.immunity.SILENCE)
    if instance then
        instance:setLocalVar('killedNMs', instance:getLocalVar('killedNMs') + 1)
    end
end

-- upon trading card to slot, jakko aggroed a completely different target
entity.onMobEngage = function(mob, target)
    local alliance = target:getAlliance()

    if alliance then
        local zone = target:getZoneID()

        for _, member in pairs(alliance) do
            if
                member:getZoneID() == zone and
                member:isAlive() and
                mob:checkDistance(member) <= 50
            then
                mob:setCE(member, mob:getCE(member) + 1)
                mob:setVE(member, mob:getVE(member) + (math.random(0, 6) * 20))
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
