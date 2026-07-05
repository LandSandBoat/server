-----------------------------------
-- Area : Qu'Bia Arena
-- Mob  : Nephiyl Moatfiller
-- BCNM : Demolition Squad
-- Job  : Beastmaster
-- NOTE : Does not have a pet. 2-hour is charm.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('charmUsed', 0)
    mob:setLocalVar('twoHourHpPercent', math.randomInt(40, 60))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getLocalVar('charmUsed') ~= 0 then
        return
    end

    if mob:getHPP() <= mob:getLocalVar('twoHourHpPercent') then
        mob:useMobAbility(xi.mobSkill.CHARM)
        mob:setLocalVar('charmUsed', 1)
    end
end

return entity
