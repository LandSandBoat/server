-----------------------------------
-- Area: Balga's Dais
--  Mob: Gilagoge Tlugvi (WHM) "Spring Tree"
-- BCNM: Season's Greetings
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('benedictionTime', 0)
end

-- If it has been more than 2 minutes since Benediction was used, gain a significant damage boost.
entity.onMobFight = function(mob, target)
    if mob:getMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER) == 250 then
        return
    end

    local benedictionTime = mob:getLocalVar('benedictionTime')

    if
        benedictionTime > 0 and
        GetSystemTime() > benedictionTime + 120
    then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance  = 25,
        element = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(mob, target, pTable)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.ENTANGLE
end

-- If Benediction is used, the Monk tree (Goga Tlugvi) attacks.
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    if skillID == xi.mobSkill.BENEDICTION_1 then
        local currentTime = GetSystemTime()
        battlefield:setLocalVar('benedictionTime', currentTime)
        local baseId = mob:getID()
        local summerTree = GetMobByID(baseId + 1)

        if summerTree and summerTree:isAlive() then
            local currentTarget = mob:getTarget()
            if not currentTarget then
                return
            end

            summerTree:updateEnmity(currentTarget)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BANISH_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [ 2] = { xi.magic.spell.BANISHGA_II, target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [ 3] = { xi.magic.spell.HOLY,        target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 },
        [ 4] = { xi.magic.spell.CURE_V,      mob,    true,  xi.action.type.HEALING_TARGET,     33,                  0, 100 },
        [ 5] = { xi.magic.spell.CURAGA_II,   mob,    true,  xi.action.type.HEALING_FORCE_SELF, 33,                  0, 100 },
        [ 6] = { xi.magic.spell.BLINDNA,     mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.BLINDNESS, 0, 100 },
        [ 7] = { xi.magic.spell.PARALYNA,    mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.PARALYSIS, 0, 100 },
        [ 8] = { xi.magic.spell.POISONA,     mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.POISON,    0, 100 },
        [ 9] = { xi.magic.spell.SILENA,      mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.SILENCE,   0, 100 },
        [10] = { xi.magic.spell.VIRUNA,      mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.DISEASE,   0, 100 },
        [11] = { xi.magic.spell.VIRUNA,      mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.PLAGUE,    0, 100 },
        [12] = { xi.magic.spell.AQUAVEIL,    mob,    false, xi.action.type.ENHANCING_TARGET,   xi.effect.AQUAVEIL,  0, 100 },
        [13] = { xi.magic.spell.BLINK,       mob,    false, xi.action.type.ENHANCING_TARGET,   xi.effect.BLINK,     0, 100 },
        [14] = { xi.magic.spell.PROTECT_IV,  mob,    true,  xi.action.type.ENHANCING_TARGET,   xi.effect.PROTECT,   0,  25 },
        [15] = { xi.magic.spell.SHELL_IV,    mob,    true,  xi.action.type.ENHANCING_TARGET,   xi.effect.SHELL,     0,  25 },
        [16] = { xi.magic.spell.DIA_II,      target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DIA,       3,  50 },
        [17] = { xi.magic.spell.DIAGA_II,    target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DIA,       3,  50 },
        [18] = { xi.magic.spell.PARALYZE,    target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.PARALYSIS, 0, 100 },
        [19] = { xi.magic.spell.SILENCE,     target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SILENCE,   0, 100 },
    }

    local groupTable =
    {
        GetMobByID(mob:getID() + 1), -- Goga Tlugvi       (MNK) "Summer Tree"
        GetMobByID(mob:getID() + 2), -- Ulagohvsdi Tlugvi (NIN) "Autumn Tree"
        GetMobByID(mob:getID() + 3), -- Gola Tlugvi       (DRK) "Winter Tree"
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
