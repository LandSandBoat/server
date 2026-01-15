-----------------------------------
-- Area: Jade Sepulcher
--   NM: Phantom Puk
-----------------------------------
mixins = { require('scripts/mixins/families/puk') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.REQUIEM)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('boreas_mantle', GetSystemTime() + math.random(15, 45))
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()
    if mob:getLocalVar('boreas_mantle') <= currentTime then
        mob:useMobAbility(xi.mobSkill.BOREAS_MANTLE, mob)
        mob:setLocalVar('boreas_mantle', currentTime + math.random(60, 90))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local mobID = mob:getID()
    for cloneID = mobID + 1, mobID + 4 do
        local clone = GetMobByID(cloneID)
        if clone then
            local action = clone:getCurrentAction()
            if action ~= xi.action.category.NONE and action ~= xi.action.category.DEATH then
                DespawnMob(cloneID)
            end
        end
    end
end

return entity
