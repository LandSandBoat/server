-----------------------------------
-- Area: Jade Sepulcher
--   NM: Phantom Puk
-----------------------------------
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.REQUIEM)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('boreas_mantle', os.time() + math.random(15, 45))
end

entity.onMobFight = function(mob, target)
    local now = os.time()
    if mob:getLocalVar('boreas_mantle') <= now then
        mob:useMobAbility(xi.mobSkill.BOREAS_MANTLE, mob)
        mob:setLocalVar('boreas_mantle', now + math.random(60, 90))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local mobID = mob:getID()
    for cloneID = mobID + 1, mobID + 4 do
        local clone = GetMobByID(cloneID)
        if clone then
            local action = clone:getCurrentAction()
            if action ~= xi.act.NONE and action ~= xi.act.DEATH then
                DespawnMob(cloneID)
            end
        end
    end
end

return entity
