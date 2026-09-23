-----------------------------------
-- Area: Mamool Ja Training Grounds
--  Mob: Mamool Ja Warder (NIN)
-- Involved in Assault: Imperial Agent Rescue
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, 50)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    mob:setMod(xi.mod.STORETP, 10)
end

-- Skill selection, Firespit has higher weight when near a Dilapidated Gate.
entity.onMobMobskillChoose = function(mob, target, skillId)
    local gate      = xi.assault.contents[xi.assault.mission.IMPERIAL_AGENT_RESCUE].findGate(mob)
    local skillList =
    {
        [1] = { xi.mobSkill.SOMERSAULT_KICK_1,       20 },
        [2] = { xi.mobSkill.WARM_UP_1,               20 },
        [3] = { xi.mobSkill.FORCEFUL_BLOW,           20 },
        [4] = { xi.mobSkill.FIRESPIT, gate and 85 or 20 },
    }

    local weightSum = 0
    for i = 1, #skillList do
        weightSum = weightSum + skillList[i][2]
    end

    local randomRoll = math.randomInt(1, weightSum)
    weightSum = 0
    for i = 1, #skillList do
        weightSum = weightSum + skillList[i][2]
        if randomRoll <= weightSum then
            return skillList[i][1]
        end
    end
end

-- If Firespit is chosen, redirect target to the gate.
entity.onMobSkillTarget = function(target, mob, skill)
    local skillId = skill:getID()
    local gate    = xi.assault.contents[xi.assault.mission.IMPERIAL_AGENT_RESCUE].findGate(mob)

    if not gate then
        return target
    end

    if skillId == xi.mobSkill.FIRESPIT then
        return gate
    end

    return target
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.UTSUSEMI_NI, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.COPY_IMAGE, 0, 100 },
        [ 2] = { xi.magic.spell.HOJO_NI,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,       4, 100 },
        [ 3] = { xi.magic.spell.KURAYAMI_NI, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,  0, 100 },
        [ 4] = { xi.magic.spell.DOKUMORI_NI, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     0, 100 },
        [ 5] = { xi.magic.spell.KATON_NI,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 6] = { xi.magic.spell.HYOTON_NI,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 7] = { xi.magic.spell.HUTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 8] = { xi.magic.spell.DOTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 9] = { xi.magic.spell.RAITON_NI,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [10] = { xi.magic.spell.SUITON_NI,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
