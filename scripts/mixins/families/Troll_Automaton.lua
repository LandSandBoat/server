-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.trollAutomaton = xi.mix.trollAutomaton or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local automatonTypes =
{
    {
        name = 'Harlequin',
        job = xi.job.RDM,
        modelId = 1977,
        isCaster = true,
        spellList = 567,
    },

    {
        name = 'Valoredge',
        job = xi.job.PLD,
        modelId = 1983,
        doubleAttack = 15,
    },

    {
        name = 'Sharpshot',
        job = xi.job.RNG,
        modelId = 1990,
        isRanged = true,
        standbackHp = 70,
        specialCool = 12,
        specialSkill = xi.mobSkill.RANGED_ATTACK_1,
        rangedAttackRange = 13,
    },

    {
        name = 'Stormwalker',
        job = xi.job.RDM,
        modelId = 1994,
        isCaster = true,
        spellList = 566,
        standbackHp = 70,
    },
}

g_mixins.families.Troll_Automaton = function(automatonMob)
    automatonMob:addListener('SPAWN', 'TROLL_AUTOMATON_SPAWN', function(mob)
        xi.mix.trollAutomaton.setupAutomaton(mob, automatonTypes[math.randomInt(1, #automatonTypes)])
    end)
end

xi.mix.trollAutomaton.setupAutomaton = function(mob, automatonType)
    mob:setLocalVar('automatonTypeModelId', automatonType.modelId)
    mob:setModelId(automatonType.modelId)
    mob:changeJob(automatonType.job)
    mob:setDelay(270) -- All Frames (Waiting for delay conversion PR to be merged)
    mob:setMod(xi.mod.DOUBLE_ATTACK, automatonType.doubleAttack or 0) -- Valoredge Frame
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 27) -- Harlequin and Stormwalker
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, math.randomInt(3, 7)) -- Harlequin and Stormwalker
    mob:setSpellList(automatonType.spellList or 0) -- Harlequin and Stormwalker
    mob:setMagicCastingEnabled(automatonType.isCaster or false) -- Harlequin & Stormwalker
    mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.STANDBACK))) -- Sharpshot and Stormwalker
    mob:setMobMod(xi.mobMod.HP_STANDBACK, automatonType.standbackHp or 0) -- Sharpshot and Stormwalker
    mob:setMobMod(xi.mobMod.SPECIAL_COOL, automatonType.specialCool or 0) -- Sharpshot Frame
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, automatonType.specialSkill or 0) -- Sharpshot Frame
    mob:setMobMod(xi.mobMod.RANGED_ATTACK_RANGE, automatonType.rangedAttackRange or 0) -- Sharpshot Frame

    return automatonType
end

xi.mix.trollAutomaton.onMobMobskillChoose = function(mob, target)
    local modelId = mob:getModelId()
    local skillList = {}

    switch(modelId): caseof
    {
        [1977] = function() -- Harlequin
            table.insert(skillList, xi.mobSkill.SLAPSTICK_AUTOMATON)
        end,

        [1983] = function() -- Valoredge
            table.insert(skillList, xi.mobSkill.CHIMERA_RIPPER_AUTOMATON)
            table.insert(skillList, xi.mobSkill.STRING_CLIPPER_AUTOMATON)
            table.insert(skillList, xi.mobSkill.SHIELD_BASH_AUTOMATON)
        end,

        [1990] = function() -- Sharpshot
            table.insert(skillList, xi.mobSkill.SLAPSTICK_AUTOMATON)
            table.insert(skillList, xi.mobSkill.ARCUBALLISTA_AUTOMATON)
        end,

        [1994] = function() -- Stormwalker
            table.insert(skillList, xi.mobSkill.SLAPSTICK_AUTOMATON)
        end,
    }

    if #skillList == 0 then
        return 0
    end

    return skillList[math.randomInt(1, #skillList)]
end

return g_mixins.families.Troll_Automaton
