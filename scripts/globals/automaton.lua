-----------------------------------
--  Automaton Global
-----------------------------------
xi = xi or {}
xi.automaton = xi.automaton or {}

-- [FRAME][HEAD] = Model ID
local automatonModels =
{
    [xi.automaton.frame.HARLEQUIN] =
    {
        [xi.automaton.head.HARLEQUIN   ] = 0x07B9,
        [xi.automaton.head.VALOREDGE   ] = 0x07BA,
        [xi.automaton.head.SHARPSHOT   ] = 0x07BC,
        [xi.automaton.head.STORMWAKER  ] = 0x07BB,
        [xi.automaton.head.SOULSOOTHER ] = 0x07D3,
        [xi.automaton.head.SPIRITREAVER] = 0x07D7,
    },
    [xi.automaton.frame.VALOREDGE] =
    {
        [xi.automaton.head.HARLEQUIN   ] = 0x07BE,
        [xi.automaton.head.VALOREDGE   ] = 0x07BF,
        [xi.automaton.head.SHARPSHOT   ] = 0x07C1,
        [xi.automaton.head.STORMWAKER  ] = 0x07C0,
        [xi.automaton.head.SOULSOOTHER ] = 0x07D4,
        [xi.automaton.head.SPIRITREAVER] = 0x07D8,
    },
    [xi.automaton.frame.SHARPSHOT] =
    {
        [xi.automaton.head.HARLEQUIN   ] = 0x07C3,
        [xi.automaton.head.VALOREDGE   ] = 0x07C4,
        [xi.automaton.head.SHARPSHOT   ] = 0x07C6,
        [xi.automaton.head.STORMWAKER  ] = 0x07C5,
        [xi.automaton.head.SOULSOOTHER ] = 0x07D5,
        [xi.automaton.head.SPIRITREAVER] = 0x07D9,
    },
    [xi.automaton.frame.STORMWAKER] =
    {
        [xi.automaton.head.HARLEQUIN   ] = 0x07C8,
        [xi.automaton.head.VALOREDGE   ] = 0x07C9,
        [xi.automaton.head.SHARPSHOT   ] = 0x07CB,
        [xi.automaton.head.STORMWAKER  ] = 0x07CA,
        [xi.automaton.head.SOULSOOTHER ] = 0x07D6,
        [xi.automaton.head.SPIRITREAVER] = 0x07DA,
    },
}

local maneuverList =
{
    [xi.jobAbility.FIRE_MANEUVER   ] = { effect = xi.effect.FIRE_MANEUVER,    element = xi.element.FIRE,    stat = xi.mod.STR },
    [xi.jobAbility.ICE_MANEUVER    ] = { effect = xi.effect.ICE_MANEUVER,     element = xi.element.ICE,     stat = xi.mod.INT },
    [xi.jobAbility.WIND_MANEUVER   ] = { effect = xi.effect.WIND_MANEUVER,    element = xi.element.WIND,    stat = xi.mod.AGI },
    [xi.jobAbility.EARTH_MANEUVER  ] = { effect = xi.effect.EARTH_MANEUVER,   element = xi.element.EARTH,   stat = xi.mod.VIT },
    [xi.jobAbility.THUNDER_MANEUVER] = { effect = xi.effect.THUNDER_MANEUVER, element = xi.element.THUNDER, stat = xi.mod.DEX },
    [xi.jobAbility.WATER_MANEUVER  ] = { effect = xi.effect.WATER_MANEUVER,   element = xi.element.WATER,   stat = xi.mod.MND },
    [xi.jobAbility.LIGHT_MANEUVER  ] = { effect = xi.effect.LIGHT_MANEUVER,   element = xi.element.LIGHT,   stat = xi.mod.CHR },
    [xi.jobAbility.DARK_MANEUVER   ] = { effect = xi.effect.DARK_MANEUVER,    element = xi.element.DARK,    stat = nil        },
}

-- Table of attachment modifiers.
-- Modifiers are keyed by number of maneuvers active. 0 / 1 / 2 / 3
-- Regen & Refresh values are calculated separately in their own function and left nil on purpose.
xi.automaton.attachmentModifiers =
{
    ['accelerator'        ] = { { modifier = xi.mod.EVA,                         values = {     5,    10,    15,    20 }, opticFiber = true  }, },
    ['accelerator_ii'     ] = { { modifier = xi.mod.EVA,                         values = {    10,    15,    20,    25 }, opticFiber = true  }, },
    ['accelerator_iii'    ] = { { modifier = xi.mod.EVA,                         values = {    20,    30,    40,    50 }, opticFiber = true  }, },
    ['accelerator_iv'     ] = { { modifier = xi.mod.EVA,                         values = {    30,    45,    60,    80 }, opticFiber = true  }, },
    ['analyzer'           ] = { { modifier = xi.mod.AUTO_ANALYZER,               values = {     1,     2,     4,     6 }, opticFiber = false }, },
    ['amplifier'          ] = { { modifier = xi.mod.MAGIC_BURST_BONUS_UNCAPPED,  values = {    10,    20,    35,    50 }, opticFiber = true  },
                                { modifier = xi.mod.ELEMENTAL_CELERITY,          values = {    25,    25,    25,    25 }, opticFiber = true  }, },
    ['amplifier_ii'       ] = { { modifier = xi.mod.MAGIC_BURST_BONUS_UNCAPPED,  values = {    20,    30,    50,    70 }, opticFiber = true  },
                                { modifier = xi.mod.ELEMENTAL_CELERITY,          values = {    25,    25,    25,    25 }, opticFiber = true  }, },
    ['arcanic_cell'       ] = { { modifier = xi.mod.OCCULT_ACUMEN,               values = {    10,    20,    35,    50 }, opticFiber = true  }, },
    ['arcanic_cell_ii'    ] = { { modifier = xi.mod.OCCULT_ACUMEN,               values = {    20,    40,    70,   100 }, opticFiber = true  }, },
    ['arcanoclutch'       ] = { { modifier = xi.mod.MAGIC_DAMAGE,                values = {    20,    40,    60,    80 }, opticFiber = true  }, },
    ['arcanoclutch_ii'    ] = { { modifier = xi.mod.MAGIC_DAMAGE,                values = {    40,    60,    80,   120 }, opticFiber = true  }, },
    ['armor_plate'        ] = { { modifier = xi.mod.DMGPHYS,                     values = {  -500,  -700, -1000, -1500 }, opticFiber = true  }, },
    ['armor_plate_ii'     ] = { { modifier = xi.mod.DMGPHYS,                     values = { -1000, -1500, -2000, -2500 }, opticFiber = true  }, },
    ['armor_plate_iii'    ] = { { modifier = xi.mod.DMGPHYS,                     values = { -1500, -2000, -2500, -3000 }, opticFiber = true  }, },
    ['armor_plate_iv'     ] = { { modifier = xi.mod.DMGPHYS,                     values = { -2000, -2500, -3000, -4000 }, opticFiber = true  }, },
    ['auto-repair_kit'    ] = { { modifier = xi.mod.REGEN,                       values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['auto-repair_kit_ii' ] = { { modifier = xi.mod.REGEN,                       values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['auto-repair_kit_iii'] = { { modifier = xi.mod.REGEN,                       values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['auto-repair_kit_iv' ] = { { modifier = xi.mod.REGEN,                       values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['barrier_module'     ] = { { modifier = xi.mod.SHIELDBLOCKRATE,             values = {     0,     5,    10,    15 }, opticFiber = true  },
                                { modifier = xi.mod.AUTO_SHIELD_BASH_DELAY,      values = {     0,     5,    10,    15 }, opticFiber = false }, },
    ['barrier_module_ii'  ] = { { modifier = xi.mod.SHIELDBLOCKRATE,             values = {     0,    10,    20,    30 }, opticFiber = true  },
                                { modifier = xi.mod.AUTO_SHIELD_BASH_DELAY,      values = {     0,     5,    10,    15 }, opticFiber = false }, },
    ['coiler'             ] = { { modifier = xi.mod.DOUBLE_ATTACK,               values = {     3,    10,    20,    30 }, opticFiber = true  }, },
    ['coiler_ii'          ] = { { modifier = xi.mod.DOUBLE_ATTACK,               values = {    10,    15,    25,    35 }, opticFiber = true  }, },
    ['damage_gauge'       ] = { { modifier = xi.mod.AUTO_HEALING_THRESHOLD,      values = {    50,    60,    70,    80 }, opticFiber = false },
                                { modifier = xi.mod.AUTO_HEALING_DELAY,          values = {     3,     3,     3,     3 }, opticFiber = false }, },
    ['damage_gauge_ii'    ] = { { modifier = xi.mod.AUTO_HEALING_THRESHOLD,      values = {    60,    70,    80,    90 }, opticFiber = false },
                                { modifier = xi.mod.AUTO_HEALING_DELAY,          values = {     3,     3,     3,     3 }, opticFiber = false }, },
    ['drum_magazine'      ] = { { modifier = xi.mod.AUTO_RANGED_DELAY,           values = {     3,     6,     9,    15 }, opticFiber = true  }, },
    ['dynamo'             ] = { { modifier = xi.mod.CRITHITRATE,                 values = {     3,     5,     7,     9 }, opticFiber = true  }, },
    ['dynamo_ii'          ] = { { modifier = xi.mod.CRITHITRATE,                 values = {     5,    10,    15,    20 }, opticFiber = true  }, },
    ['dynamo_iii'         ] = { { modifier = xi.mod.CRITHITRATE,                 values = {    10,    15,    25,    35 }, opticFiber = true  }, },
    ['flame_holder'       ] = { { modifier = xi.mod.WEAPONSKILL_DAMAGE_BASE,     values = {   125,   200,   275,   350 }, opticFiber = true  }, },
    ['equalizer'          ] = { { modifier = xi.mod.AUTO_EQUALIZER,              values = {    10,    25,    50,    75 }, opticFiber = true  }, },
    ['galvanizer'         ] = { { modifier = xi.mod.COUNTER,                     values = {    10,    20,    35,    50 }, opticFiber = true  }, },
    ['hammermill'         ] = { { modifier = xi.mod.SHIELD_BASH,                 values = {    15,    25,    50,   100 }, opticFiber = true  },
                                { modifier = xi.mod.AUTO_SHIELD_BASH_SLOW,       values = {     0,    12,    19,    25 }, opticFiber = true  }, },
    ['heatsink'           ] = { { modifier = xi.mod.BURDEN_DECAY,                values = {     2,     4,     5,     6 }, opticFiber = false }, },
    ['ice_maker'          ] = { { modifier = xi.mod.AUTO_MAB_COEFFICIENT,        values = {     0,    50,    75,   100 }, opticFiber = true  }, },
    ['inhibitor'          ] = { { modifier = xi.mod.STORETP,                     values = {     5,    15,    25,    40 }, opticFiber = true  }, },
    ['inhibitor_ii'       ] = { { modifier = xi.mod.STORETP,                     values = {    10,    25,    40,    65 }, opticFiber = true  }, },
    ['loudspeaker'        ] = { { modifier = xi.mod.MATT,                        values = {     5,    10,    15,    20 }, opticFiber = true  }, },
    ['loudspeaker_ii'     ] = { { modifier = xi.mod.MATT,                        values = {    10,    15,    20,    25 }, opticFiber = true  }, },
    ['loudspeaker_iii'    ] = { { modifier = xi.mod.MATT,                        values = {    20,    30,    40 ,   50 }, opticFiber = true  }, },
    ['loudspeaker_iv'     ] = { { modifier = xi.mod.MATT,                        values = {    30,    40,    50,    60 }, opticFiber = true  }, },
    ['loudspeaker_v'      ] = { { modifier = xi.mod.MATT,                        values = {    40,    50,    60,    70 }, opticFiber = true  }, },
    ['magniplug'          ] = { { modifier = xi.mod.MAIN_DMG_RATING,             values = {     5,    15,    30,    45 }, opticFiber = true  },
                                { modifier = xi.mod.RANGED_DMG_RATING,           values = {     5,    15,    30,    45 }, opticFiber = true  }, },
    ['magniplug_ii'       ] = { { modifier = xi.mod.MAIN_DMG_RATING,             values = {    10,    20,    35,    50 }, opticFiber = true  },
                                { modifier = xi.mod.RANGED_DMG_RATING,           values = {    10,    20,    35,    50 }, opticFiber = true  }, },
    ['mana_booster'       ] = { { modifier = xi.mod.FASTCAST,                    values = {    20,    30,    45,    60 }, opticFiber = false }, },
    ['mana_channeler'     ] = { { modifier = xi.mod.MATT,                        values = {    10,    15,    25,    35 }, opticFiber = true  },
                                { modifier = xi.mod.AUTO_MAGIC_COOLDOWN,         values = {     3,     6,     9,    12 }, opticFiber = true  }, },
    ['mana_channeler_ii'  ] = { { modifier = xi.mod.MATT,                        values = {    20,    30,    40,    50 }, opticFiber = true  },
                                { modifier = xi.mod.AUTO_MAGIC_COOLDOWN,         values = {     6,    12,    18,    24 }, opticFiber = true  }, },
    ['mana_conserver'     ] = { { modifier = xi.mod.CONSERVE_MP,                 values = {    15,    30,    45,    60 }, opticFiber = true  }, },
    ['mana_jammer'        ] = { { modifier = xi.mod.MDEF,                        values = {    10,    20,    30,    40 }, opticFiber = true  }, },
    ['mana_jammer_ii'     ] = { { modifier = xi.mod.MDEF,                        values = {    20,    30,    40,    50 }, opticFiber = true  }, },
    ['mana_jammer_iii'    ] = { { modifier = xi.mod.MDEF,                        values = {    30,    40,    50,    60 }, opticFiber = true  }, },
    ['mana_jammer_iv'     ] = { { modifier = xi.mod.MDEF,                        values = {    40,    50,    60,    70 }, opticFiber = true  }, },
    ['mana_tank'          ] = { { modifier = xi.mod.REFRESH,                     values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['mana_tank_ii'       ] = { { modifier = xi.mod.REFRESH,                     values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['mana_tank_iii'      ] = { { modifier = xi.mod.REFRESH,                     values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['mana_tank_iv'       ] = { { modifier = xi.mod.REFRESH,                     values = {   nil,   nil,   nil,   nil }, opticFiber = true  }, },
    ['optic_fiber'        ] = { { modifier = xi.mod.AUTO_PERFORMANCE_BOOST,      values = {    10,    20,    25,    30 }, opticFiber = false }, },
    ['optic_fiber_ii'     ] = { { modifier = xi.mod.AUTO_PERFORMANCE_BOOST,      values = {    15,    30,    37,    45 }, opticFiber = false }, },
    ['percolator'         ] = { { modifier = xi.mod.COMBAT_SKILLUP_RATE,         values = {     5,    10,    15,    20 }, opticFiber = true  }, },
    ['power_cooler'       ] = { { modifier = xi.mod.MP_COST_REDUCTION,           values = {    10,    20,    35,    50 }, opticFiber = true  }, },
    ['repeater'           ] = { { modifier = xi.mod.DOUBLE_SHOT_RATE,            values = {    10,    15,    35,    65 }, opticFiber = true  }, },
    ['resister'           ] = { { modifier = xi.mod.STATUSRES,                   values = {     5,    10,    20,    30 }, opticFiber = true  }, },
    ['resister_ii'        ] = { { modifier = xi.mod.STATUSRES,                   values = {    10,    20,    40,    60 }, opticFiber = true  }, },
    ['scanner'            ] = { { modifier = xi.mod.AUTO_SCAN_RESISTS,           values = {     0,     1,     1,     1 }, opticFiber = false }, },
    ['schurzen'           ] = { { modifier = xi.mod.AUTO_SCHURZEN,               values = {     0,     1,     1,     1 }, opticFiber = false }, },
    ['scope'              ] = { { modifier = xi.mod.RACC,                        values = {    10,    20,    30,    40 }, opticFiber = true  }, },
    ['scope_ii'           ] = { { modifier = xi.mod.RACC,                        values = {    20,    30,    40,    50 }, opticFiber = true  }, },
    ['scope_iii'          ] = { { modifier = xi.mod.RACC,                        values = {    30,    40,    55,    70 }, opticFiber = true  }, },
    ['scope_iv'           ] = { { modifier = xi.mod.RACC,                        values = {    40,    50,    65,    80 }, opticFiber = true  }, },
    ['speedloader'        ] = { { modifier = xi.mod.SKILLCHAINBONUS,             values = {    20,    30,    40,    60 }, opticFiber = true  }, },
    ['speedloader_ii'     ] = { { modifier = xi.mod.SKILLCHAINBONUS,             values = {    35,    45,    60,    80 }, opticFiber = true  }, },
    ['smoke_screen'       ] = { { modifier = xi.mod.EVA,                         values = {    20,    40,    80,   160 }, opticFiber = true  },
                                { modifier = xi.mod.ACC,                         values = {   -20,   -40,   -80,  -160 }, opticFiber = true  },
                                { modifier = xi.mod.RACC,                        values = {   -20,   -40,   -80,  -160 }, opticFiber = true  }, },
    ['stabilizer'         ] = { { modifier = xi.mod.ACC,                         values = {     5,    10,    15,    20 }, opticFiber = true  }, },
    ['stabilizer_ii'      ] = { { modifier = xi.mod.ACC,                         values = {    10,    15,    20,    25 }, opticFiber = true  }, },
    ['stabilizer_iii'     ] = { { modifier = xi.mod.ACC,                         values = {    20,    30,    40,    50 }, opticFiber = true  }, },
    ['stabilizer_iv'      ] = { { modifier = xi.mod.ACC,                         values = {    30,    40,    55,    70 }, opticFiber = true  }, },
    ['stabilizer_v'       ] = { { modifier = xi.mod.ACC,                         values = {    40,    50,    65,    80 }, opticFiber = true  }, },
    ['stealth_screen'     ] = { { modifier = xi.mod.ENMITY,                      values = {   -10,   -20,   -30,   -40 }, opticFiber = true  }, },
    ['stealth_screen_ii'  ] = { { modifier = xi.mod.ENMITY,                      values = {   -15,   -25,   -35,   -45 }, opticFiber = true  }, },
    ['steam_jacket'       ] = { { modifier = xi.mod.AUTO_STEAM_JACKET_REDUCTION, values = {    30,    45,    60,    80 }, opticFiber = true  }, },
    ['strobe'             ] = { { modifier = xi.mod.ENMITY,                      values = {    10,    25,    40,    60 }, opticFiber = true  }, },
    ['strobe_ii'          ] = { { modifier = xi.mod.ENMITY,                      values = {    20,    40,    65,   100 }, opticFiber = true  }, },
    ['tactical_processor' ] = { { modifier = xi.mod.AUTO_DECISION_DELAY,         values = {    50,    70,    85,   115 }, opticFiber = false }, },
    ['tension_spring'     ] = { { modifier = xi.mod.ATTP,                        values = {     3,     6,     9,    12 }, opticFiber = true  },
                                { modifier = xi.mod.RATTP,                       values = {     3,     6,     9,    12 }, opticFiber = true  }, },
    ['tension_spring_ii'  ] = { { modifier = xi.mod.ATTP,                        values = {     6,     9,    12,    15 }, opticFiber = true  },
                                { modifier = xi.mod.RATTP,                       values = {     6,     9,    12,    15 }, opticFiber = true  }, },
    ['tension_spring_iii' ] = { { modifier = xi.mod.ATTP,                        values = {    12,    15,    18,    21 }, opticFiber = true  },
                                { modifier = xi.mod.RATTP,                       values = {    12,    15,    18,    21 }, opticFiber = true  }, },
    ['tension_spring_iv'  ] = { { modifier = xi.mod.ATTP,                        values = {    15,    18,    21,    24 }, opticFiber = true  },
                                { modifier = xi.mod.RATTP,                       values = {    15,    18,    21,    24 }, opticFiber = true  }, },
    ['tension_spring_v'   ] = { { modifier = xi.mod.ATTP,                        values = {    18,    21,    24,    27 }, opticFiber = true  },
                                { modifier = xi.mod.RATTP,                       values = {    18,    21,    24,    27 }, opticFiber = true  }, },
    ['tranquilizer'       ] = { { modifier = xi.mod.MACC,                        values = {    10,    30,    40,    50 }, opticFiber = true  }, },
    ['tranquilizer_ii'    ] = { { modifier = xi.mod.MACC,                        values = {    20,    40,    55,    70 }, opticFiber = true  }, },
    ['tranquilizer_iii'   ] = { { modifier = xi.mod.MACC,                        values = {    30,    50,    70,    80 }, opticFiber = true  }, },
    ['tranquilizer_iv'    ] = { { modifier = xi.mod.MACC,                        values = {    40,    60,    80,   110 }, opticFiber = true  }, },
    ['truesights'         ] = { { modifier = xi.mod.AUTO_RANGED_DAMAGEP,         values = {     5,    15,    30,    45 }, opticFiber = true  }, },
    ['turbo_charger'      ] = { { modifier = xi.mod.HASTE_MAGIC,                 values = {   500,  1500,  2000,  2500 }, opticFiber = true  }, },
    ['turbo_charger_ii'   ] = { { modifier = xi.mod.HASTE_MAGIC,                 values = {   700,  1700,  2800,  4375 }, opticFiber = true  }, },
    ['vivi-valve'         ] = { { modifier = xi.mod.CURE_POTENCY,                values = {     5,    15,    30,    45 }, opticFiber = true  }, },
    ['vivi-valve_ii'      ] = { { modifier = xi.mod.CURE_POTENCY,                values = {    10,    20,    35,    50 }, opticFiber = true  }, },
    ['volt_gun'           ] = { { modifier = xi.mod.VOLT_GUN_POTENCY,            values = {     0,    20,    40,   100 }, opticFiber = false }, },
}

-----------------------------------
-- Attuner
-----------------------------------
---@param actor CBaseEntity
---@param target CBaseEntity
---@return number
xi.automaton.handleAttuner = function(actor, target)
    if not actor:isAutomaton() then
        return 0
    end

    if not actor:hasAttachmentSet(xi.item.ATTUNER_ATTACHMENT) then
        return 0
    end

    if actor:getMainLvl() >= target:getMainLvl() then
        return 0
    end

    local master = actor:getMaster()

    if not master then
        return 0
    end

    -- We have reason to believe BG wiki is wrong about the attuner values
    -- so we are using these for the moment; JP wiki and dev posts imply that it's not as simple as level + 1 and higher gets massive def ignore.
    local fireManeuversActive = xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.FIRE_MANEUVER))

    local attunerEffect =
    {
        [0] = 0.05,
        [1] = 0.10,
        [2] = 0.15,
        [3] = 0.20
    }

    return attunerEffect[fireManeuversActive] or 0
end

-----------------------------------
-- Auto Repair Kit
-----------------------------------
-- Repair Kit HP boost is calculated per frame using the attachment's hpBoost and the frame divisor.
-- Example: Repair Kit IV on Harlequin is 4 / 20 = 0.2, or a 20% HP boost.
xi.automaton.repairKit =
{
    frameDivisors =
    {
        [xi.automaton.frame.HARLEQUIN ] = 20,
        [xi.automaton.frame.VALOREDGE ] = 24,
        [xi.automaton.frame.SHARPSHOT ] = 18,
        [xi.automaton.frame.STORMWAKER] = 16,
    },

    data =
    {
        ['auto-repair_kit'    ] = { id = 193, hpBoost = 1, regenBase = { 0,  1,  2,  3 }, regenMultiplier = { 0, 0.125, 0.225, 0.375 } },
        ['auto-repair_kit_ii' ] = { id = 196, hpBoost = 2, regenBase = { 0,  3,  6,  9 }, regenMultiplier = { 0, 0.600, 1.200, 1.800 } },
        ['auto-repair_kit_iii'] = { id = 202, hpBoost = 3, regenBase = { 0,  9, 12, 15 }, regenMultiplier = { 0, 1.800, 2.400, 3.000 } },
        ['auto-repair_kit_iv' ] = { id = 205, hpBoost = 4, regenBase = { 0, 15, 18, 21 }, regenMultiplier = { 0, 3.000, 3.600, 4.200 } },
    },
}

local function getRegenModValue(pet, attachment, numManeuvers)
    local repairKitData = xi.automaton.repairKit.data[attachment:getName()]
    if not repairKitData then
        return 0
    end

    return repairKitData.regenBase[numManeuvers + 1] + pet:getMaxHP() * repairKitData.regenMultiplier[numManeuvers + 1] / 100
end

-----------------------------------
-- Coiler
-----------------------------------
-- Returns the number of extra hits granted by the DOUBLE_ATTACK modifier based on the base number of hits.
xi.automaton.getExtraHits = function(automaton, numHits)
    local doubleAttackRate = utils.clamp(automaton:getMod(xi.mod.DOUBLE_ATTACK), 0, 100)
    local extraHits        = 0
    if doubleAttackRate > 0 then
        for _ = 1, numHits do
            if math.randomInt(1, 100) <= doubleAttackRate then
                extraHits = extraHits + 1
            end
        end
    end

    return extraHits
end

-----------------------------------
-- Equalizer
-----------------------------------
---@param actor CBaseEntity
---@param damage integer
---@return integer
xi.automaton.handleEqualizer = function(actor, damage)
    local equalizerModifier = actor:getMod(xi.mod.AUTO_EQUALIZER)
    local maxHP             = actor:getMaxHP()

    -- No Equalizer Equipped, return unmodified damage.
    if equalizerModifier == 0 then
        return damage
    end

    -- No Damage to reduce, return unmodified damage.
    if damage <= 0 then
        return damage
    end

    -- Equalizer damage reduction becomes more effective the higher the damage is in relation to the automatons max HP.
    local reductionRate = (damage / maxHP) * (equalizerModifier / 100)

    reductionRate = math.floor(reductionRate * 100) / 100

    -- Damage reduction is capped at 90%.
    reductionRate = math.min(reductionRate, 0.90)

    return math.floor(damage * (1 - reductionRate))
end

-----------------------------------
-- Flame Holder
-----------------------------------
-- Applies the FTP multiplier for an Automaton Weapon Skill, factoring in the WEAPONSKILL_DAMAGE_BASE modifier from Flame Holder.
xi.automaton.applyFlameHolder = function(automaton, ftp)
    local flameHolderFTP = automaton:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE) / 100
    if flameHolderFTP > 0 then
        ftp[1] = ftp[1] * flameHolderFTP
        ftp[2] = ftp[2] * flameHolderFTP
        ftp[3] = ftp[3] * flameHolderFTP
    end
end

-----------------------------------
-- Mana Tank
-----------------------------------
-- Mana Tank MP boost is calculated per frame using the attachment's mpBoost and the frame divisor.
-- Example: Mana Tank IV on Harlequin is 4 / 20 = 0.2, or a 20% MP boost.
xi.automaton.manaTank =
{
    frameDivisors =
    {
        [xi.automaton.frame.HARLEQUIN ] = 20,
        [xi.automaton.frame.STORMWAKER] = 24,
    },

    data =
    {
        ['mana_tank'    ] = { id = 225, mpBoost = 1, refreshBase = { 0, 1, 2, 3 }, refreshMultiplier = { 0, 0.2, 0.4, 0.6 } },
        ['mana_tank_ii' ] = { id = 228, mpBoost = 2, refreshBase = { 0, 2, 3, 4 }, refreshMultiplier = { 0, 0.4, 0.6, 0.8 } },
        ['mana_tank_iii'] = { id = 233, mpBoost = 3, refreshBase = { 0, 3, 4, 5 }, refreshMultiplier = { 0, 0.6, 0.8, 1.0 } },
        ['mana_tank_iv' ] = { id = 235, mpBoost = 4, refreshBase = { 0, 4, 5, 6 }, refreshMultiplier = { 0, 0.8, 1.0, 1.2 } },
    },
}

local function getRefreshModValue(pet, attachment, numManeuvers)
    local manaTankData = xi.automaton.manaTank.data[attachment:getName()]
    if not manaTankData then
        return 0
    end

    return manaTankData.refreshBase[numManeuvers + 1] + pet:getMaxMP() * manaTankData.refreshMultiplier[numManeuvers + 1] / 100
end

-----------------------------------
-- Optic Fiber
-----------------------------------
local function isOpticFiber(attachmentName)
    if string.find(attachmentName, 'optic_fiber') ~= nil then
        return true
    end

    return false
end

-- Due to load order, we can't expect to determine Optic Fiber enhancements on change.
-- For maneuvers, calculate this based on the number of light maneuvers that are active.
local function calculatePerformanceBoost(pet)
    local master           = pet:getMaster()
    local performanceBoost = 0

    local lightManeuversActive = xi.automaton.getManeuverCount(master, master and master:countEffect(xi.effect.LIGHT_MANEUVER) or 0)
    for _, attachmentName in pairs(pet:getAttachments()) do
        if
            isOpticFiber(attachmentName) and
            xi.automaton.attachmentModifiers[attachmentName]
        then
            performanceBoost = performanceBoost + xi.automaton.attachmentModifiers[attachmentName][1].values[lightManeuversActive + 1]
        end
    end

    return performanceBoost
end

-----------------------------------
-- Truesights
-----------------------------------
-- Return the base damage of an Automaton Ranged Attack, factoring in the AUTO_RANGED_DAMAGEP modifier.
xi.automaton.getRangedBaseDamage = function(automaton)
    return automaton:getRangedDmg() * (1 + automaton:getMod(xi.mod.AUTO_RANGED_DAMAGEP) / 100)
end

-----------------------------------
-- Volt Gun
-----------------------------------
-- Calculates the potency of Volt Gun AE. TODO: Additional dINT testing.
xi.automaton.calculateVoltGunPotency = function(automaton, target)
    local voltGunModifier = automaton:getMod(xi.mod.VOLT_GUN_POTENCY)
    local skillLevel      = math.max(automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE), automaton:getSkillLevel(xi.skill.AUTOMATON_RANGED), automaton:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    local basePotency     = math.floor(skillLevel / 16)
    local dINT            = automaton:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local power           = math.min(math.max(math.floor(dINT / 2), -10), 30)

    return math.max(math.floor((basePotency + power) * (1 + voltGunModifier / 100)), 1)
end

-----------------------------------
-- Animator Check
-----------------------------------
local function hasAnimatorEquipped(player)
    if
        player:getWeaponSubSkillType(xi.slot.RANGED) == 10 or
        player:getWeaponSubSkillType(xi.slot.RANGED) == 11
    then
        return true
    end

    return false
end

-----------------------------------
-- Global functions to handle attachment modifiers.
-- NOTE: Core is 0-indexed for maneuvers, yet the table above is 1-indexed.
-- Maneuvers are updated in core before the appropriate function is called in Lua. This is why some of the functions below have offsets applied.
-----------------------------------
xi.automaton.onAttachmentEquip = function(pet, attachment)
    xi.automaton.updateAttachmentModifier(pet, attachment, 0)
end

xi.automaton.onAttachmentUnequip = function(pet, attachment)
    local attachmentName = attachment:getName()
    local modTable       = xi.automaton.attachmentModifiers[attachmentName]

    for k, modifierData in ipairs(modTable) do
        local previousMod = pet:getLocalVar(attachmentName .. k)

        if modifierData.values[4] and modifierData.values[4] < 0 then
            previousMod = previousMod * -1
        end

        if previousMod ~= 0 then
            pet:delMod(modifierData.modifier, previousMod)
        end
    end

    pet:clearLocalVarsWithPrefix(attachmentName)
end

xi.automaton.updateAttachmentModifier = function(pet, attachment, maneuvers)
    local attachmentName  = attachment:getName()
    local master          = pet:getMaster()
    local modTable        = xi.automaton.attachmentModifiers[attachmentName]
    local maneuversActive = xi.automaton.getManeuverCount(master, maneuvers)

    for modifierIndex, modifierData in ipairs(modTable) do
        local modifier           = modifierData.modifier
        local values             = modifierData.values
        local opticFiberBonus    = modifierData.opticFiber
        local attachmentVariable = attachmentName .. modifierIndex
        local previousValue      = pet:getLocalVar(attachmentVariable)

        -- Local variables are unsigned, so restore negative modifier values before comparison.
        if values[4] and values[4] < 0 then
            previousValue = previousValue * -1
        end

        local updatedValue

        if modifier == xi.mod.REGEN then
            updatedValue = getRegenModValue(pet, attachment, maneuversActive)
        elseif modifier == xi.mod.REFRESH then
            updatedValue = getRefreshModValue(pet, attachment, maneuversActive)
        else
            updatedValue = values[maneuversActive + 1]
        end

        if opticFiberBonus then
            updatedValue = math.floor(updatedValue * (1 + calculatePerformanceBoost(pet) / 100))
        end

        if updatedValue ~= previousValue then
            if previousValue ~= 0 then
                -- If the automaton was reset to a blank state (LEVEL_RESTRICTION) and the local variables were not cleared, this will under/overflow.
                pet:delMod(modifier, previousValue)
            end

            pet:addMod(modifier, updatedValue)
            pet:setLocalVar(attachmentVariable, math.abs(updatedValue))

            if master and isOpticFiber(attachmentName) then
                master:updateAttachments()
            end
        end
    end
end

-----------------------------------
-- Burden Calculation
-- https://wiki.ffo.jp/html/29192.html
-- Maneuvers cost less when the matching stat is higher than the automatons, except for dark maneuvers which have a flat cost based on the frame.
-----------------------------------
local function getAddBurdenValue(player, maneuverElement, maneuverStat)
    -- Dark Maneuvers
    if maneuverElement == xi.element.DARK then
        local frameEquipped = player:getAutomatonFrame()

        if
            frameEquipped == xi.automaton.frame.VALOREDGE or
            frameEquipped == xi.automaton.frame.SHARPSHOT
        then
            return 8
        end

        return 14
    else
        -- Fire, Ice, Wind, Earth, Lightning, Water, Light Maneuvers
        local statDifference = player:getStat(maneuverStat) - player:getPet():getStat(maneuverStat)

        if statDifference >= 4 then
            return 14
        elseif statDifference >= 0 then
            return 19 - statDifference
        else
            return 20
        end
    end
end

-----------------------------------
-- Global functions to handle maneuvers
-----------------------------------
xi.automaton.getManeuverCount = function(master, maneuvers)
    if not master then
        return 0
    end

    local maneuversActive = math.min(maneuvers, 3)

    if
        maneuversActive > 0 and
        master:hasStatusEffect(xi.effect.OVERDRIVE)
    then
        return 3
    end

    return maneuversActive
end

xi.automaton.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

xi.automaton.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

xi.automaton.onManeuverCheck = function(player, target, ability)
    if
        not player:hasStatusEffect(xi.effect.OVERLOAD) and
        player:getPet() and
        hasAnimatorEquipped(player)
    then
        return 0, 0
    else
        return 71, 0
    end
end

xi.automaton.onUseManeuver = function(player, target, ability, action)
    local pet = player:getPet()

    if not pet then
        return
    end

    local maneuverInfo = maneuverList[ability:getID()]
    local element      = maneuverInfo.element - 1
    local burdenValue  = getAddBurdenValue(player, maneuverInfo.element, maneuverInfo.stat)
    local overload     = target:addBurden(element, burdenValue)

    if
        overload ~= 0 and
        (player:getMod(xi.mod.PREVENT_OVERLOAD) > 0 or pet:getMod(xi.mod.PREVENT_OVERLOAD) > 0) and
        player:delStatusEffectSilent(xi.effect.WATER_MANEUVER)
    then
        overload = 0
    end

    action:messageID(player:getID(), xi.msg.basic.AUTO_OVERLOAD_CHANCE)

    if overload ~= 0 then
        target:removeAllManeuvers()
        target:addStatusEffect(xi.effect.OVERLOAD, { duration = overload, origin = player })
        pet:addStatusEffect(xi.effect.OVERLOAD, { duration = overload, origin = pet })
        action:messageID(player:getID(), xi.msg.basic.AUTO_OVERLOADED)
    else
        local puppetmasterLevel = target:getMainJob() == xi.job.PUP and target:getMainLvl() or target:getSubLvl()
        local maneuverBonus     = 1 + (puppetmasterLevel / 15) + target:getMod(xi.mod.MANEUVER_BONUS)

        if target:getActiveManeuverCount() == 3 then
            target:removeOldestManeuver()
        end

        target:addStatusEffect(maneuverInfo.effect, { power = maneuverBonus, duration = utils.clamp(pet:getLocalVar('MANEUVER_DURATION'), 60, 300), origin = player })
    end

    return target:getOverloadChance(element)
end

-----------------------------------
---Retrieve model ID of the automaton for cutscene purposes
-----------------------------------
---@param player CBaseEntity
---@return integer
xi.automaton.getModelId = function(player)
    local frame          = player:getAutomatonFrame()
    local head           = player:getAutomatonHead()
    local defaultModelId = automatonModels[xi.automaton.frame.HARLEQUIN][xi.automaton.head.HARLEQUIN]

    if not frame or not head then
        return defaultModelId
    end

    local frameTable = automatonModels[frame]
    if not frameTable then
        return defaultModelId
    end

    return frameTable[head] or defaultModelId
end
