-----------------------------------
-- Area: Horlais Peak
--  Mob: Dragonian Minstrel
-- KSNM30
-- TODO: Uses empowered versions of Thornsong, Lodesong and Voidsong after 2-hour. Was unable to find differences for Lodesong or Voidsong.
-- Empowered Thornsong does an incredible amount of damage. (around 120 unresisted)
-- Set up this lua to be future proof for when we add those skills.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.REGAIN, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.VOIDSONG_1,
        xi.mobSkill.LODESONG_1,
    }

    if mob:getLocalVar('soulVoiceUsed') == 0 then
        table.insert(skills, xi.mobSkill.THORNSONG_1)
        -- table.insert(skills, xi.mobSkill.VOIDSONG_1)
        -- table.insert(skills, xi.mobSkill.LODESONG_1)
    else
        table.insert(skills, xi.mobSkill.THORNSONG_2)
        -- table.insert(skills, xi.mobSkill.VOIDSONG_2)
        -- table.insert(skills, xi.mobSkill.LODESONG_2)
    end

    return skills[math.random(1, #skills)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()

    if skillID == xi.mobSkill.SOUL_VOICE_1 then
        mob:setLocalVar('soulVoiceUsed', 1)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        { xi.magic.spell.VICTORY_MARCH,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MARCH,   0, 100 },
        { xi.magic.spell.VALOR_MINUET_IV,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MINUET,  0, 100 },
        { xi.magic.spell.KNIGHTS_MINNE_IV,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MINNE,   0, 100 },
        { xi.magic.spell.ARMYS_PAEON_V,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PAEON,   0, 100 },
        { xi.magic.spell.MAGES_BALLAD_II,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BALLAD,  0, 100 },
        { xi.magic.spell.UNCANNY_ETUDE,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ETUDE,   0, 100 },
        { xi.magic.spell.SWIFT_ETUDE,       mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ETUDE,   0, 100 },
        { xi.magic.spell.FOE_REQUIEM_VI,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.REQUIEM, 0, 100 },
        { xi.magic.spell.BATTLEFIELD_ELEGY, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.ELEGY,   0, 100 },
        { xi.magic.spell.HORDE_LULLABY,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I, 0, 100 },
        { xi.magic.spell.MAGIC_FINALE,      target, false, xi.action.type.NONE,                 nil,               0,  50 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
