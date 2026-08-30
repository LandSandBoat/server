-----------------------------------
-- Area: Mamook
--   NM: Zizzy Zillah
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  83.000, y =  14.500, z = -222.000 }
}

entity.phList =
{
    [ID.mob.ZIZZY_ZILLAH + 6]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 7]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 8]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 9]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 10] = ID.mob.ZIZZY_ZILLAH,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'COCKATRICE_ABILITY', function(mobArg, skillId, wasExecuted)
        local skillUsed = skillId
        if not skillUsed or not wasExecuted then
            return
        end

        if mob:getAnimationSub() == 2 then
            return
        end

        if skillUsed == xi.mobSkill.SOUND_VACUUM_COCKATRICE then
            mob:setAnimationSub(2)
        else
            mob:setAnimationSub(1)
        end
    end)

    mob:addListener('EFFECT_GAIN', 'SILENCE_EFFECT_GAIN', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
        end
    end)

    mob:addListener('EFFECT_LOSE', 'SILENCE_EFFECT_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.SILENCE then
            mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 175)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 175)
    mob:setMod(xi.mod.REGAIN, 300) -- TP move every 25 seconds or so with no TP feed
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local sackSize   = mob:getAnimationSub()
    local isSilenced = mob:hasStatusEffect(xi.effect.SILENCE)

    if
        sackSize == 2 and
        not isSilenced
    then
        return xi.mobSkill.SOUND_BLAST
    end

    local skillList =
    {
        xi.mobSkill.BALEFUL_GAZE_COCKATRICE,
        xi.mobSkill.HAMMER_BEAK,
        xi.mobSkill.POISON_PICK,
    }

    if not isSilenced then
        table.insert(skillList, xi.mobSkill.SOUND_VACUUM_COCKATRICE)
    end

    if
        sackSize == 0 and
        not isSilenced
    then
        table.insert(skillList, xi.mobSkill.SOUND_BLAST)
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobWeaponSkill = function(mob, target, skill)
    if skill and skill:getID() == xi.mobSkill.SOUND_BLAST then
        mob:setAnimationSub(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 460)
end

return entity
