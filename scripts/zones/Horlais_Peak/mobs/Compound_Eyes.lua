-----------------------------------
-- Area: Horlais Peak
--  Mob: Compound Eyes
-- BCNM: Under Observation
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 10)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Uses Hex Eye every 15 seconds if target is not paralyzed, once target is paralyzed, this stops
    local currentTime = GetSystemTime()
    local lastSkillTime = mob:getLocalVar('lastHexeyeTime')
    if
        currentTime - lastSkillTime >= 15 and
        not target:hasStatusEffect(xi.effect.PARALYSIS)
    then
        mob:useMobAbility(xi.mobSkill.HEX_EYE)
        mob:setLocalVar('lastHexeyeTime', currentTime)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local skillList =
    {
        xi.mobSkill.DEATH_RAY,
        xi.mobSkill.PETRO_GAZE,
    }

    if mob:getHPP() <= 50 then
        table.insert(skillList, xi.mobSkill.CATHARSIS) -- Observed Catharsis usage at low HP only
    end

    return skillList[math.random(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.FIRE_II,
        xi.magic.spell.DRAIN,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
