-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Generic Doll
-- BCNM: Factory Rejects
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 9)
end

entity.onMobSpawn = function(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Increment the count of spawned dolls
    battlefield:setLocalVar('dollsSpawned', battlefield:getLocalVar('dollsSpawned') + 1)

    -- Clear isBusy variable on the factory that summoned us
    local factory = GetMobByID(battlefield:getLocalVar('factoryId'))
    if factory then
        factory:setLocalVar('isBusy', 0)
    end

    -- Update the Generic Dolls enmity to attack the first living player
    for _, player in pairs(battlefield:getPlayers()) do
        if player:isAlive() then
            mob:updateEnmity(player)
            break
        end
    end
end

-- Each Generic Doll has a unique skill set based on the order they were spawned.
local dollSkillLists =
{
    [1] = { xi.mobSkill.GRAVITY_FIELD                       },
    [2] = { xi.mobSkill.BERSERK_DOLL                        },
    [3] = { xi.mobSkill.PANZERFAUST                         },
    [4] = { xi.mobSkill.KARTSTRAHL, xi.mobSkill.BLITZSTRAHL },
    [5] = { xi.mobSkill.TYPHOON                             },
}

entity.onMobMobskillChoose = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Check to see which Doll we are and return the appropriate skill list
    local skillList = dollSkillLists[battlefield:getLocalVar('dollsSpawned')]

    return skillList[math.random(1, #skillList)]
end

entity.onMobSkillTarget = function(target, mob, skill) -- TODO: Seems that it should just "ignore" someone sleeping rather than reset enmity, this will keep the behavior similar to retail until we have a way to do this.
    if skill:getID() == xi.mobSkill.KARTSTRAHL then
        mob:resetEnmity(target)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.THUNDAGA,
        xi.magic.spell.STUN,
    }

    if not target:hasStatusEffect(xi.effect.PARALYSIS) then
        table.insert(spellList, xi.magic.spell.PARALYGA)
    end

    if not mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
        table.insert(spellList, xi.magic.spell.SHOCK_SPIKES)
    end

    return spellList[math.random(1, #spellList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BIND, { chance = 20, duration = 20 })
end

return entity
