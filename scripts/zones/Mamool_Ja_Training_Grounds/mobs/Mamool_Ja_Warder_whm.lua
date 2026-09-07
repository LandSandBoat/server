-----------------------------------
-- Area: Mamool Ja Training Grounds
--  Mob: Mamool Ja Warder (WHM)
-- Involved in Assault: Imperial Agent Rescue
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.HPP, 50)
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    mob:setMod(xi.mod.STORETP, 10)
end

-- Skill selection, Firespit & Stave Toss have higher weight when near a Dilapidated Gate.
entity.onMobMobskillChoose = function(mob, target, skillId)
    local gate      = xi.assault.contents[xi.assault.mission.IMPERIAL_AGENT_RESCUE].findGate(mob)
    local skillList =
    {
        [1] = { xi.mobSkill.SOMERSAULT_KICK_2,                     20 },
        [2] = { xi.mobSkill.WARM_UP_2,                             20 },
        [3] = { xi.mobSkill.FIRESPIT_BLUE_MAMOOLJA, gate and 60 or 20 },
    }

    if mob:getAnimationSub() == 0 then
        table.insert(skillList, { xi.mobSkill.STAVE_TOSS_1, gate and 85 or 20 })
        table.insert(skillList, { xi.mobSkill.RUSHING_DRUB,                20 })
    else
        table.insert(skillList, { xi.mobSkill.FORCEFUL_BLOW_2,             20 })
    end

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

-- If Firespit or Stave Toss are chosen, redirect target to the gate.
entity.onMobSkillTarget = function(target, mob, skill)
    local skillId = skill:getID()
    local gate    = xi.assault.contents[xi.assault.mission.IMPERIAL_AGENT_RESCUE].findGate(mob)

    if not gate then
        return target
    end

    if
        skillId == xi.mobSkill.STAVE_TOSS_1 or
        skillId == xi.mobSkill.FIRESPIT_BLUE_MAMOOLJA
    then
        return gate
    end

    return target
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.PROTECT_IV,   mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.PROTECT,     0, 100 },
        [ 2] = { xi.magic.spell.SHELL_IV,     mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.SHELL,       0, 100 },
        [ 3] = { xi.magic.spell.BLINK,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLINK,       0, 100 },
        [ 4] = { xi.magic.spell.STONESKIN,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,   0, 100 },
        [ 5] = { xi.magic.spell.AQUAVEIL,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL,    0, 100 },
        [ 6] = { xi.magic.spell.HASTE,        mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.HASTE,       5, 100 },
        [ 7] = { xi.magic.spell.BARBLIZZARA,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BARBLIZZARD, 0, 100 },
        [ 8] = { xi.magic.spell.CURE_V,       mob,    true,  xi.action.type.HEALING_TARGET,       50,                    0, 100 },
        [ 9] = { xi.magic.spell.CURAGA_IV,    mob,    true,  xi.action.type.HEALING_FORCE_SELF,   50,                    0, 100 },
        [10] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,         3, 100 },
        [11] = { xi.magic.spell.DIAGA_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,         3, 100 },
        [12] = { xi.magic.spell.SLOW,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,        3, 100 },
        [13] = { xi.magic.spell.SILENCE,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,     0, 100 },
        [14] = { xi.magic.spell.FLASH,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FLASH,       0, 100 },
        [15] = { xi.magic.spell.HOLY,         target, false, xi.action.type.DAMAGE_TARGET,        nil,                   0, 100 },
        [16] = { xi.magic.spell.BANISH_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                   0, 100 },
        [17] = { xi.magic.spell.BANISHGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                   0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, mob:getParty(), spellList)
end

return entity
