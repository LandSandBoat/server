-----------------------------------
-- Area: Riverne - Site B01
--   NM: Unstable Cluster
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:addStatusEffect(xi.effect.BLAZE_SPIKES, { power = 13, origin = mob })
    mob:getStatusEffect(xi.effect.BLAZE_SPIKES):setEffectFlags(xi.effectFlag.DEATH)
end

entity.onMobFight = function(mob, target)
    if
        mob:getAnimationSub() == 5 and
        mob:getMod(xi.mod.TRIPLE_ATTACK) == 100
    then
        mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    elseif
        mob:getAnimationSub() == 6 and
        mob:getMod(xi.mod.DOUBLE_ATTACK) == 100
    then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpList =
    {
        xi.mobSkill.REFUELING_1
    }

    local animationSub = mob:getAnimationSub()
    local mobHPP       = mob:getHPP()

    switch (animationSub) : caseof
    {
        [3] = function()
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            if mobHPP < 66 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_3)
            end
        end,

        [4] = function()
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            if mobHPP < 66 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_3)
            end
        end,

        [5] = function()
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            if mobHPP < 33 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_2)
            end
        end,

        [6] = function()
            if mobHPP < 20 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_1_DEATH)
            end
        end,
    }

    return tpList[math.random(1, #tpList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.FIRE,
        basePower      = math.floor(damage / 2),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onSpikesDamage = function(mob, target, damage)
    -- "damage" is the power of the status effect up in onMobSpawn.
    local intDiff = mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local dmg = damage + intDiff
    local params = {}
    params.bonusmab = 0
    params.includemab = false
    dmg = addBonusesAbility(mob, xi.element.FIRE, target, dmg, params)
    dmg = dmg * applyResistanceAddEffect(mob, target, xi.element.FIRE, 0)
    dmg = math.floor(dmg * xi.spells.damage.calculateAbsorption(target, xi.element.FIRE, true))
    dmg = math.floor(dmg * xi.spells.damage.calculateNullification(target, xi.element.FIRE, true, false))
    dmg = finalMagicNonSpellAdjustments(mob, target, xi.element.FIRE, dmg)

    if dmg < 0 then
        dmg = 0
    end

    return xi.subEffect.BLAZE_SPIKES, xi.msg.basic.SPIKES_EFFECT_DMG, dmg
end

return entity
