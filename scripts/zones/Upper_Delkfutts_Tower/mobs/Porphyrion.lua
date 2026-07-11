-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Porphyrion
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(30, 35))
    mob:setLocalVar('[2hour]Used', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getLocalVar('[2hour]Used') ~= 0 then
        return
    end

    if mob:getHPP() >= mob:getLocalVar('[2hour]HPP') then
        return
    end

    mob:setLocalVar('[2hour]Used', 1)
    mob:useMobAbility(xi.mobSkill.EES_GIGAS)
end

-- TODO: Spawn QM in mob's position in onMobDeath

return entity
