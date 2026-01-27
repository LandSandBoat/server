-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Disaster Idol
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.BLIND) -- TODO: Should only be dark immune, can be flashed
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.BIND_RES_RANK, 11)
    mob:setMod(xi.mod.POISON_RES_RANK, 11)
    mob:setMod(xi.mod.DARK_RES_RANK, 11)
    mob:setMod(xi.mod.MATT, 68)
    mob:setMod(xi.mod.REGEN, 5)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.KARTSTRAHL,
        xi.mobSkill.BLITZSTRAHL,
        xi.mobSkill.PANZERFAUST,
        xi.mobSkill.BERSERK_DOLL,
        xi.mobSkill.PANZERSCHRECK,
        xi.mobSkill.TYPHOON,
        xi.mobSkill.GRAVITY_FIELD,
    }

    return skillList[math.random(1, #skillList)]
end

-- Disaster Idol dynamically adjusts his level based on his current target's level
entity.onMobFight = function(mob, target)
    if not target then
        return
    end

    local targetLevel = target:getMainLvl()
    local currentStatLevel = mob:getLocalVar('currentStatLevel')

    if targetLevel ~= currentStatLevel then

        mob:setMobLevel(utils.clamp(targetLevel, 55, 85), false)
        mob:setLocalVar('currentStatLevel', targetLevel)
    end
end

-- Casts spells based on the current in game day
-- Changes what spells cast based on the current target's level
entity.onMobSpellChoose = function(mob, target, spellId)
    local targetLevel = target:getMainLvl()
    local dayElement = VanadielDayElement()
    local spellLists =
    {
        -- Firesday
        [xi.element.FIRE] =
        {
            [1] = { xi.magic.spell.FIRE_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100,  1, 61 },
            [2] = { xi.magic.spell.FIRE_III,    target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100, 62, 72 },
            [3] = { xi.magic.spell.FIRE_IV,     target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100, 73, 99 },
            [4] = { xi.magic.spell.FLARE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100, 60, 99 },
            [5] = { xi.magic.spell.FIRAGA_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100,  1, 68 },
            [6] = { xi.magic.spell.FIRAGA_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100, 69, 99 },
            [7] = { xi.magic.spell.BURN,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BURN,   0, 100,  1, 99 },
            [8] = { xi.magic.spell.ENFIRE,      mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENFIRE, 0, 100,  1, 99 },
        },

        -- Earthsday
        [xi.element.EARTH] =
        {
            [1] = { xi.magic.spell.STONE_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 67 },
            [2] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 68, 76 },
            [3] = { xi.magic.spell.STONE_V,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 77, 99 },
            [4] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 99 },
            [5] = { xi.magic.spell.STONEGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 62 },
            [6] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 63, 99 },
            [7] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.RASP,       0, 100,  1, 99 },
            [8] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN,  0, 100,  1, 99 },
            [9] = { xi.magic.spell.ENSTONE,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENSTONE,    0, 100,  1, 99 },
        },

        -- Watersday
        [xi.element.WATER] =
        {
            [ 1] = { xi.magic.spell.WATER_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100,  1, 54 },
            [ 2] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100, 55, 69 },
            [ 3] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100, 70, 79 },
            [ 4] = { xi.magic.spell.WATER_V,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100, 80, 99 },
            [ 5] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100, 58, 99 },
            [ 6] = { xi.magic.spell.WATERGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100,  1, 64 },
            [ 7] = { xi.magic.spell.WATERGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100, 65, 99 },
            [ 8] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DROWN,     0, 100,  1, 99 },
            [ 9] = { xi.magic.spell.POISONGA_II, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,    0, 100,  1, 99 },
            [10] = { xi.magic.spell.AQUAVEIL,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.AQUAVEIL,  0, 100,  1, 99 },
            [11] = { xi.magic.spell.ENWATER,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENWATER,   0, 100,  1, 99 },
        },

        -- Windsday
        [xi.element.WIND] =
        {
            [ 1] = { xi.magic.spell.AERO_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100,  1, 58 },
            [ 2] = { xi.magic.spell.AERO_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100, 59, 71 },
            [ 3] = { xi.magic.spell.AERO_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100, 72, 82 },
            [ 4] = { xi.magic.spell.AERO_V,     target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100, 83, 99 },
            [ 5] = { xi.magic.spell.TORNADO,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100,  1, 99 },
            [ 6] = { xi.magic.spell.AEROGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100,  1, 66 },
            [ 7] = { xi.magic.spell.AEROGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100, 67, 99 },
            [ 8] = { xi.magic.spell.CHOKE,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHOKE,   0, 100,  1, 99 },
            [ 9] = { xi.magic.spell.SILENCE,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SILENCE, 0, 100,  1, 99 },
            [10] = { xi.magic.spell.BLINK,      mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,   0, 100,  1, 99 },
            [11] = { xi.magic.spell.ENAERO,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENAERO,  0, 100,  1, 99 },
        },

        -- Iceday
        [xi.element.ICE] =
        {
            [ 1] = { xi.magic.spell.BLIZZARD_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 63 },
            [ 2] = { xi.magic.spell.BLIZZARD_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 64, 73 },
            [ 3] = { xi.magic.spell.BLIZZARD_IV,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 74, 99 },
            [ 4] = { xi.magic.spell.FREEZE,        target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 99 },
            [ 5] = { xi.magic.spell.BLIZZAGA_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 57, 70 },
            [ 6] = { xi.magic.spell.BLIZZAGA_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 71, 99 },
            [ 7] = { xi.magic.spell.FROST,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FROST,      0, 100,  1, 99 },
            [ 8] = { xi.magic.spell.PARALYZE,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS,  0, 100,  1, 99 },
            [ 9] = { xi.magic.spell.BIND,          target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,       0, 100,  1, 99 },
            [10] = { xi.magic.spell.ICE_SPIKES,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ICE_SPIKES, 0, 100,  1, 99 },
            [11] = { xi.magic.spell.ENBLIZZARD,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENBLIZZARD, 0, 100,  1, 99 },
        },

        -- Lightningsday
        [xi.element.THUNDER] =
        {
            [ 1] = { xi.magic.spell.THUNDER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100,  1, 65 },
            [ 2] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100, 66, 74 },
            [ 3] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100, 75, 99 },
            [ 4] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100, 56, 99 },
            [ 5] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100, 61, 72 },
            [ 6] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100, 73, 99 },
            [ 7] = { xi.magic.spell.SHOCK,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SHOCK,        0, 100,  1, 99 },
            [ 8] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,         0, 100,  1, 99 },
            [ 9] = { xi.magic.spell.SHOCK_SPIKES, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.SHOCK_SPIKES, 0, 100,  1, 99 },
            [10] = { xi.magic.spell.ENTHUNDER,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENTHUNDER,    0, 100,  1, 99 },
        },

        -- Lightsday
        [xi.element.LIGHT] =
        {
            [ 1] = { xi.magic.spell.BANISH_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 64 },
            [ 2] = { xi.magic.spell.BANISH_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 65, 75 },
            [ 3] = { xi.magic.spell.BANISH_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100, 76, 99 },
            [ 4] = { xi.magic.spell.HOLY,         target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 99 },
            [ 5] = { xi.magic.spell.BANISHGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100,  1, 99 },
            [ 6] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,        3, 100,  1, 99 },
            [ 7] = { xi.magic.spell.DIAGA_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,        3, 100,  1, 99 },
            [ 8] = { xi.magic.spell.FLASH,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,      0, 100,  1, 99 },
            [ 9] = { xi.magic.spell.DISPELGA,     target, false, xi.action.type.ENFEEBLING_TARGET, nil,                  0, 100,  1, 99 },
            [10] = { xi.magic.spell.BLINK,        mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,      0, 100,  1, 99 },
            [11] = { xi.magic.spell.STONESKIN,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN,  0, 100,  1, 99 },
            [12] = { xi.magic.spell.HASTE,        mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.HASTE,      0, 100,  1, 99 },
            [13] = { xi.magic.spell.SHELL_IV,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,      0, 100,  1, 99 },
            [14] = { xi.magic.spell.REGEN,        mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.REGEN,      0, 100,  1, 99 },
        },

        -- Darksday
        [xi.element.DARK] =
        {
            [ 1] = { xi.magic.spell.DRAIN,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100,  1, 99 },
            [ 2] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100,  1, 99 },
            [ 3] = { xi.magic.spell.BIO_III,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       0, 100,  1, 99 },
            [ 4] = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 0, 100,  1, 99 },
            [ 5] = { xi.magic.spell.SLEEPGA,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   0, 100,  1, 55 },
            [ 6] = { xi.magic.spell.SLEEPGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_II,  0, 100, 56, 99 },
            [ 7] = { xi.magic.spell.DISPEL,      target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [ 8] = { xi.magic.spell.ABSORB_STR,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [ 9] = { xi.magic.spell.ABSORB_DEX,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [10] = { xi.magic.spell.ABSORB_VIT,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [11] = { xi.magic.spell.ABSORB_AGI,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [12] = { xi.magic.spell.ABSORB_INT,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [13] = { xi.magic.spell.ABSORB_MND,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
            [14] = { xi.magic.spell.ABSORB_CHR,  target, false, xi.action.type.ENFEEBLING_TARGET, nil,                 0, 100,  1, 99 },
        },
    }

    -- Filter spells based on target level
    local validSpells = {}
    local daySpells = spellLists[dayElement]

    if daySpells then
        for _, spellData in pairs(daySpells) do
            local minLevel = spellData[8] or 1
            local maxLevel = spellData[9] or 99

            if targetLevel >= minLevel and targetLevel <= maxLevel then
                table.insert(validSpells, spellData)
            end
        end
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, validSpells)
end

return entity
