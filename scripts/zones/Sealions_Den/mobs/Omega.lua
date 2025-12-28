-----------------------------------
-- Area: Sealions Den
--  Mob: Omega
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.ATTP, 30)
end

entity.onMobFight = function(mob, target)
    local hpp = mob:getHPP()

    if hpp < 20 then
        mob:setDelay(1100)
        mob:setMod(xi.mod.ATTP, 100)
    elseif hpp < 60 then
        mob:setDelay(2100)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local hpp      = mob:getHPP()
    local tpSkills = {}

    -- Phase 1 (100-20%): Standard skills
    if hpp >= 20 then
        tpSkills =
        {
            xi.mobSkill.HYPER_PULSE,
            xi.mobSkill.ION_EFFLUX,
            xi.mobSkill.GUIDED_MISSILE,
            xi.mobSkill.TARGET_ANALYSIS,
        }

        -- Rear Lasers available when target is behind Omega
        if target:isBehind(mob) then
            table.insert(tpSkills, xi.mobSkill.REAR_LASERS)
        end

    -- Phase 2 (<20%): Critical skills
    else
        tpSkills =
        {
            xi.mobSkill.PILE_PITCH,
            xi.mobSkill.DISCHARGER,
        }
    end

    return tpSkills[math.random(1, #tpSkills)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

return entity
