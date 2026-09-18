-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Wamoura Prince
-- Note: Can transform into a Wamoura.
-----------------------------------
mixins = { require('scripts/mixins/families/wamouracampa') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('eclosionTime', GetSystemTime() + math.randomInt(1800, 3600))
end

entity.onMobRoam = function(mob)
    if GetSystemTime() < mob:getLocalVar('eclosionTime') then
        return
    end

    mob:useMobAbility(xi.mobSkill.ECLOSION, mob)
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('eclosionTime', GetSystemTime() + math.randomInt(1800, 3600))
end

return entity
