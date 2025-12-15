-----------------------------------
-- Area: Misareaux Coast
--   NM: Upyri
-- TODO: Determine if earring can only drop at night
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addMod(xi.mod.REGAIN, 150)
end

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.BLOOD_DRAIN_1,
        xi.mobSkill.MARROW_DRAIN_1,
        xi.mobSkill.SUBSONICS_1,
        xi.mobSkill.ULTRASONICS_1,
    }

    local totd = VanadielTOTD()
    if
        totd == xi.time.NIGHT or
        totd == xi.time.MIDNIGHT
    then
        table.insert(tpMoves, xi.mobSkill.SOUL_ACCRETION)
    end

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId     = skill:getID()
    local totd        = VanadielTOTD()
    local repeatCount = mob:getLocalVar('repeatSkillCount')

    if
        (totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT) and
        (skillId == xi.mobSkill.SOUL_ACCRETION or skillId == xi.mobSkill.BLOOD_DRAIN_1)
    then
        if repeatCount < 1 then
            mob:setLocalVar('repeatSkillCount', repeatCount + 1)
            mob:queue(0, function(mobArg)
                mobArg:useMobAbility(skillId)
            end)
        else
            mob:setLocalVar('repeatSkillCount', 0)
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hr
end

return entity
