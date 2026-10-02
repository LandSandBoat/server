-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Porphyrion
-- Note: Mob uses EES and ranged attacks but is WAR main job.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, xi.mobSkill.CATAPULT)
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, 14)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 6)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 66)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[2hour]HPP', math.randomInt(30, 50))
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
