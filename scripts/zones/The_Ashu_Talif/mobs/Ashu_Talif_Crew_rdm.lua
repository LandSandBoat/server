-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--  Mob: Ashu Talif Crew (RDM)
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
---@type TMobEntity
local entity = {}

local function getCrewGroupTargets(mob)
    local instance = mob:getInstance()
    if not instance then
        return {}
    end

    local waveTable =
    {
        [1] =
        {
            ID.mob.ASHU_CREW_OFFSET,
            ID.mob.ASHU_CREW_OFFSET + 1,
            ID.mob.ASHU_CREW_OFFSET + 2,
            ID.mob.ASHU_CREW_OFFSET + 3,
            ID.mob.ASHU_CREW_OFFSET + 4,
        },
        [2] =
        {
            ID.mob.ASHU_CAPTAIN_OFFSET,
            ID.mob.ASHU_CAPTAIN_OFFSET + 1,
            ID.mob.ASHU_CAPTAIN_OFFSET + 2,
            ID.mob.ASHU_CAPTAIN_OFFSET + 3,
            ID.mob.ASHU_CAPTAIN_OFFSET + 4,
        },
    }

    local wave = instance:getProgress() >= 5 and 2 or 1

    local groupTable = {}
    for _, memberId in ipairs(waveTable[wave]) do
        local member = GetMobByID(memberId, instance)
        if member and member:isAlive() then
            table.insert(groupTable, member)
        end
    end

    return groupTable
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local groupTable = getCrewGroupTargets(mob)

    local spellList =
    {
        [1]  = { xi.magic.spell.PROTECT_III,  mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT,   0, 100 },
        [2]  = { xi.magic.spell.SHELL_III,    mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,     0, 100 },
        [3]  = { xi.magic.spell.STONESKIN,    mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN, 0, 100 },
        [4]  = { xi.magic.spell.BLINK,        mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,     0, 100 },
        [5]  = { xi.magic.spell.AQUAVEIL,     mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.AQUAVEIL,  0, 100 },
        [6]  = { xi.magic.spell.HASTE,        mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.HASTE,     1, 100 },
        [7]  = { xi.magic.spell.ENWATER,      mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.ENWATER,   0, 100 },
        [8]  = { xi.magic.spell.THUNDER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [9]  = { xi.magic.spell.BLIZZARD_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [10] = { xi.magic.spell.AERO_II,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [11] = { xi.magic.spell.WATER_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [12] = { xi.magic.spell.STONE_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [13] = { xi.magic.spell.POISON_II,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,    0, 100 },
        [14] = { xi.magic.spell.DIAGA_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,       3, 100 },
        [15] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       4, 100 },
        [16] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,       3, 100 },
        [17] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_II,  2, 100 },
        [18] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   1, 100 },
        [19] = { xi.magic.spell.GRAVITY,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.WEIGHT,    0, 100 },
        [20] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,      0, 100 },
        [21] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 0, 100 },
        [22] = { xi.magic.spell.PARALYZE,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS, 0, 100 },
        [23] = { xi.magic.spell.SLOW,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW,      3, 100 },
    }

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPEL, target, false, xi.action.type.NONE, nil, 0, 100 })
    end

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if
        instance and
        (optParams.isKiller or optParams.noKiller)
    then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
