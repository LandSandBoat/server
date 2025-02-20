-----------------------------------
--  Automaton Global
-----------------------------------
xi = xi or {}
xi.automaton = {}

xi.automaton.abilities =
{
    CHIMERA_RIPPER  = 1940,
    STRING_CLIPPER  = 1941,
    ARCUBALLISTA    = 1942,
    SLAPSTICK       = 1943,
    SHIELD_BASH     = 1944,
    PROVOKE         = 1945,
    SHOCK_ABSORBER  = 1946,
    FLASHBULB       = 1947,
    MANA_CONVERTER  = 1948,
    RANGED_ATTACK   = 1949,
    ERASER          = 2021,
    REACTIVE_SHIELD = 2031,
    CANNIBAL_BLADE  = 2065,
    DAZE            = 2066,
    KNOCKOUT        = 2067,
    ECONOMIZER      = 2068,
    REPLICATOR      = 2132,
    BONE_CRUSHER    = 2299,
    ARMOR_PIERCER   = 2300,
    MAGIC_MORTAR    = 2301,
    STRING_SHREDDER = 2743,
    ARMOR_SHATTERER = 2744,
    HEAT_CAPACITOR  = 2745,
    BARRAGE_TURBINE = 2746,
    DISRUPTOR       = 2747,
}

local maneuverList =
{
    ['dark_maneuver']    = { xi.effect.DARK_MANEUVER,    xi.element.DARK,    nil        },
    ['earth_maneuver']   = { xi.effect.EARTH_MANEUVER,   xi.element.EARTH,   xi.mod.VIT },
    ['fire_maneuver']    = { xi.effect.FIRE_MANEUVER,    xi.element.FIRE,    xi.mod.STR },
    ['ice_maneuver']     = { xi.effect.ICE_MANEUVER,     xi.element.ICE,     xi.mod.INT },
    ['light_maneuver']   = { xi.effect.LIGHT_MANEUVER,   xi.element.LIGHT,   xi.mod.CHR },
    ['thunder_maneuver'] = { xi.effect.THUNDER_MANEUVER, xi.element.THUNDER, xi.mod.DEX },
    ['water_maneuver']   = { xi.effect.WATER_MANEUVER,   xi.element.WATER,   xi.mod.MND },
    ['wind_maneuver']    = { xi.effect.WIND_MANEUVER,    xi.element.WIND,    xi.mod.AGI },
}

-- This table contains modifiers granted by attachments based on maneuver.  It uses
-- full values per maneuver, and should not be additive unless the mod is granted by
-- a separate attachment.
-- NOTE: Regen and Refresh are handled outside of the table, and nil is on purpose.
local attachmentModifiers =
{
--                                                                        Num. Maneuvers
--  Attachment                    Modifier                                0,       1,     2,     3    Optic Fiber Bonus
    ['accelerator']         = { { xi.mod.EVA,                         {     5,    10,    15,    20 }, true  }, },
    ['accelerator_ii']      = { { xi.mod.EVA,                         {    10,    15,    20,    25 }, true  }, },
    ['accelerator_iii']     = { { xi.mod.EVA,                         {    20,    30,    40,    50 }, true  }, },
    ['accelerator_iv']      = { { xi.mod.EVA,                         {    30,    45,    60,    80 }, true  }, },
    ['analyzer']            = { { xi.mod.AUTO_ANALYZER,               {     1,     2,     4,     6 }, true  }, },
    ['arcanic_cell']        = { { xi.mod.OCCULT_ACUMEN,               {    10,    20,    35,    50 }, true  }, },
    ['arcanic_cell_ii']     = { { xi.mod.OCCULT_ACUMEN,               {    20,    40,    70,   100 }, true  }, },
    ['arcanoclutch']        = { { xi.mod.MAGIC_DAMAGE,                {    20,    40,    60,    80 }, true  }, },
    ['arcanoclutch_ii']     = { { xi.mod.MAGIC_DAMAGE,                {    40,    60,    80,   120 }, true  }, },
    ['armor_plate']         = { { xi.mod.DMGPHYS,                     {  -500,  -700, -1000, -1500 }, true  }, },
    ['armor_plate_ii']      = { { xi.mod.DMGPHYS,                     { -1000, -1500, -2000, -2500 }, true  }, },
    ['armor_plate_iii']     = { { xi.mod.DMGPHYS,                     { -1500, -2000, -2500, -3000 }, true  }, },
    ['armor_plate_iv']      = { { xi.mod.DMGPHYS,                     { -2000, -2500, -3000, -4000 }, true  }, },
    ['auto-repair_kit']     = { { xi.mod.HPP,                         {     5,     5,     5,     5 }, false },
                                { xi.mod.REGEN,                       {   nil,   nil,   nil,   nil }, true  }, },
    ['auto-repair_kit_ii']  = { { xi.mod.HPP,                         {    10,    10,    10,    10 }, false },
                                { xi.mod.REGEN,                       {   nil,   nil,   nil,   nil }, true  }, },
    ['auto-repair_kit_iii'] = { { xi.mod.HPP,                         {    15,    15,    15,    15 }, false },
                                { xi.mod.REGEN,                       {   nil,   nil,   nil,   nil }, true  }, },
    ['auto-repair_kit_iv']  = { { xi.mod.HPP,                         {    20,    20,    20,    20 }, false },
                                { xi.mod.REGEN,                       {   nil,   nil,   nil,   nil }, true  }, },
    ['coiler']              = { { xi.mod.DOUBLE_ATTACK,               {     3,    10,    20,    30 }, true  }, },
    ['coiler_ii']           = { { xi.mod.DOUBLE_ATTACK,               {    10,    15,    25,    35 }, true  }, },
    ['damage_gauge']        = { { xi.mod.AUTO_HEALING_THRESHOLD,      {    30,    40,    50,    75 }, true  },
                                { xi.mod.AUTO_HEALING_DELAY,          {     3,     6,     8,    10 }, false }, },
    ['drum_magazine']       = { { xi.mod.AUTO_RANGED_DELAY,           {     3,     6,     9,    15 }, true  }, },
    ['dynamo']              = { { xi.mod.CRITHITRATE,                 {     3,     5,     7,     9 }, true  }, },
    ['dynamo_ii']           = { { xi.mod.CRITHITRATE,                 {     5,    10,    15,    20 }, true  }, },
    ['dynamo_iii']          = { { xi.mod.CRITHITRATE,                 {    10,    15,    25,    35 }, true  }, },
    ['equalizer']           = { { xi.mod.AUTO_EQUALIZER,              {    10,    25,    50,    75 }, true  }, },
    ['galvanizer']          = { { xi.mod.COUNTER,                     {    10,    20,    35,    50 }, true  }, },
    ['hammermill']          = { { xi.mod.SHIELD_BASH,                 {    15,    25,    50,   100 }, true  },
                                { xi.mod.AUTO_SHIELD_BASH_SLOW,       {     0,    12,    19,    25 }, true  }, },
    ['heatsink']            = { { xi.mod.BURDEN_DECAY,                {     2,     4,     5,     6 }, true  }, },
    ['inhibitor']           = { { xi.mod.STORETP,                     {     5,    15,    25,    40 }, true  },
                                { xi.mod.AUTO_TP_EFFICIENCY,          {   900,   900,   900,   900 }, false }, },
    ['inhibitor_ii']        = { { xi.mod.STORETP,                     {    10,    25,    40,    65 }, true  },
                                { xi.mod.AUTO_TP_EFFICIENCY,          {   900,   900,   900,   900 }, false }, },
    ['loudspeaker']         = { { xi.mod.MATT,                        {     5,    10,    15,    20 }, true  }, },
    ['loudspeaker_ii']      = { { xi.mod.MATT,                        {    10,    15,    20,    25 }, true  }, },
    ['loudspeaker_iii']     = { { xi.mod.MATT,                        {    20,    30,    40 ,   50 }, true  }, },
    ['loudspeaker_iv']      = { { xi.mod.MATT,                        {    30,    40,    50,    60 }, true  }, },
    ['loudspeaker_v']       = { { xi.mod.MATT,                        {    40,    50,    60,    70 }, true  }, },
    ['magniplug']           = { { xi.mod.MAIN_DMG_RATING,             {     5,    15,    30,    45 }, true  },
                                { xi.mod.RANGED_DMG_RATING,           {     5,    15,    30,    45 }, true  }, },
    ['magniplug_ii']        = { { xi.mod.MAIN_DMG_RATING,             {    10,    20,    35,    50 }, true  },
                                { xi.mod.RANGED_DMG_RATING,           {    10,    20,    35,    50 }, true  }, },
    ['mana_booster']        = { { xi.mod.AUTO_MAGIC_DELAY,            {     2,     4,     6,     8 }, false }, },
    ['mana_conserver']      = { { xi.mod.CONSERVE_MP,                 {    15,    30,    45,    60 }, true  }, },
    ['mana_jammer']         = { { xi.mod.MDEF,                        {    10,    20,    30,    40 }, true  }, },
    ['mana_jammer_ii']      = { { xi.mod.MDEF,                        {    20,    30,    40,    50 }, true  }, },
    ['mana_jammer_iii']     = { { xi.mod.MDEF,                        {    30,    40,    50,    60 }, true  }, },
    ['mana_jammer_iv']      = { { xi.mod.MDEF,                        {    40,    50,    60,    70 }, true  }, },
    ['mana_tank']           = { { xi.mod.MPP,                         {     5,     5,     5,     5 }, false },
                                { xi.mod.REFRESH,                     {   nil,   nil,   nil,   nil }, true  }, },
    ['mana_tank_ii']        = { { xi.mod.MPP,                         {    10,    10,    10,    10 }, false },
                                { xi.mod.REFRESH,                     {   nil,   nil,   nil,   nil }, true  }, },
    ['mana_tank_iii']       = { { xi.mod.MPP,                         {    15,    15,    15,    15 }, false },
                                { xi.mod.REFRESH,                     {   nil,   nil,   nil,   nil }, true  }, },
    ['mana_tank_iv']        = { { xi.mod.MPP,                         {    20,    20,    20,    20 }, false },
                                { xi.mod.REFRESH,                     {   nil,   nil,   nil,   nil }, true  }, },
    ['optic_fiber']         = { { xi.mod.AUTO_PERFORMANCE_BOOST,      {    10,    20,    25,    30 }, false }, },
    ['optic_fiber_ii']      = { { xi.mod.AUTO_PERFORMANCE_BOOST,      {    15,    30,    37,    45 }, false }, },
    ['percolator']          = { { xi.mod.COMBAT_SKILLUP_RATE,         {     5,    10,    15,    20 }, true  }, },
    ['repeater']            = { { xi.mod.DOUBLE_SHOT_RATE,            {    10,    15,    35,    65 }, true  }, },
    ['scanner']             = { { xi.mod.AUTO_SCAN_RESISTS,           {     0,     1,     1,     1 }, false }, },
    ['schurzen']            = { { xi.mod.AUTO_SCHURZEN,               {     0,     1,     1,     1 }, false }, },
    ['scope']               = { { xi.mod.RACC,                        {    10,    20,    30,    40 }, true  }, },
    ['scope_ii']            = { { xi.mod.RACC,                        {    20,    30,    40,    50 }, true  }, },
    ['scope_iii']           = { { xi.mod.RACC,                        {    30,    40,    55,    70 }, true  }, },
    ['scope_iv']            = { { xi.mod.RACC,                        {    40,    50,    65,    80 }, true  }, },
    ['speedloader']         = { { xi.mod.SKILLCHAINBONUS,             {    20,    30,    40,    60 }, true  },
                                { xi.mod.AUTO_TP_EFFICIENCY,          {   900,   900,   900,   900 }, false }, },
    ['speedloader_ii']      = { { xi.mod.SKILLCHAINBONUS,             {    35,    45,    60,    80 }, true  },
                                { xi.mod.AUTO_TP_EFFICIENCY,          {   900,   900,   900,   900 }, false }, },
    ['stabilizer']          = { { xi.mod.ACC,                         {     5,    10,    15,    20 }, true  }, },
    ['stabilizer_ii']       = { { xi.mod.ACC,                         {    10,    15,    20,    25 }, true  }, },
    ['stabilizer_iii']      = { { xi.mod.ACC,                         {    20,    30,    40,    50 }, true  }, },
    ['stabilizer_iv']       = { { xi.mod.ACC,                         {    30,    40,    55,    70 }, true  }, },
    ['stabilizer_v']        = { { xi.mod.ACC,                         {    40,    50,    65,    80 }, true  }, },
    ['stealth_screen']      = { { xi.mod.ENMITY,                      {   -10,   -20,   -30,   -40 }, true  }, },
    ['stealth_screen_ii']   = { { xi.mod.ENMITY,                      {   -15,   -25,   -35,   -45 }, true  }, },
    ['steam_jacket']        = { { xi.mod.AUTO_STEAM_JACKET,           {     2,     3,     4,     5 }, false },
                                { xi.mod.AUTO_STEAM_JACKET_REDUCTION, {    30,    45,    60,    80 }, true  }, },
    ['strobe']              = { { xi.mod.ENMITY,                      {    10,    25,    40,    60 }, true  }, },
    ['strobe_ii']           = { { xi.mod.ENMITY,                      {    20,    40,    65,   100 }, true  }, },
    ['tactical_processor']  = { { xi.mod.AUTO_DECISION_DELAY,         {    50,    70,    85,   115 }, false }, },
    ['tension_spring']      = { { xi.mod.ATTP,                        {     3,     6,     9,    12 }, true  },
                                { xi.mod.RATTP,                       {     3,     6,     9,    12 }, true  }, },
    ['tension_spring_ii']   = { { xi.mod.ATTP,                        {     6,     9,    12,    15 }, true  },
                                { xi.mod.RATTP,                       {     6,     9,    12,    15 }, true  }, },
    ['tension_spring_iii']  = { { xi.mod.ATTP,                        {    12,    15,    18,    21 }, true  },
                                { xi.mod.RATTP,                       {    12,    15,    18,    21 }, true  }, },
    ['tension_spring_iv']   = { { xi.mod.ATTP,                        {    15,    18,    21,    24 }, true  },
                                { xi.mod.RATTP,                       {    15,    18,    21,    24 }, true  }, },
    ['tension_spring_v']    = { { xi.mod.ATTP,                        {    18,    21,    24,    27 }, true  },
                                { xi.mod.RATTP,                       {    18,    21,    24,    27 }, true  }, },
    ['tranquilizer']        = { { xi.mod.MACC,                        {    10,    30,    40,    50 }, true  }, },
    ['tranquilizer_ii']     = { { xi.mod.MACC,                        {    20,    40,    55,    70 }, true  }, },
    ['tranquilizer_iii']    = { { xi.mod.MACC,                        {    30,    50,    70,    80 }, true  }, },
    ['tranquilizer_iv']     = { { xi.mod.MACC,                        {    40,    60,    80,   110 }, true  }, },
    ['truesights']          = { { xi.mod.AUTO_RANGED_DAMAGEP,         {     5,    15,    30,    45 }, true  }, },
    ['turbo_charger']       = { { xi.mod.HASTE_MAGIC,                 {   500,  1500,  2000,  2500 }, true  }, },
    ['turbo_charger_ii']    = { { xi.mod.HASTE_MAGIC,                 {   700,  1700,  2800,  4375 }, true  }, },
    ['vivi-valve']          = { { xi.mod.CURE_POTENCY,                {     5,    15,    30,    45 }, true  }, },
    ['vivi-valve_ii']       = { { xi.mod.CURE_POTENCY,                {    10,    20,    35,    50 }, true  }, },
    ['volt_gun']            = { { xi.mod.ENSPELL,                     {     5,     5,     5,     5 }, false },
                                { xi.mod.ENSPELL_CHANCE,              {     20,   35,    50,    65 }, false }, },
}

-- Auto Repair Kits and Mana Tanks use a formula based on Max HP/MP in the form of
-- <baseValue> + <X% of Max HP/MP>.  This table represents those two variables.
local regenRefreshFormulas =
{
    -- Attachment               BaseValue          Multiplier (%)
    ['auto-repair_kit']     = { { 0,  1,  2,  3 }, { 0, 0.125, 0.225, 0.375 } },
    ['auto-repair_kit_ii']  = { { 0,  3,  6,  9 }, { 0,   0.6,   1.2,   1.8 } },
    ['auto-repair_kit_iii'] = { { 0,  9, 12, 15 }, { 0,   1.8,   2.4,   3.0 } },
    ['auto-repair_kit_iv']  = { { 0, 15, 18, 21 }, { 0,   3.0,   3.6,   4.2 } },
    ['mana_tank']           = { { 0,  1,  2,  3 }, { 0,   0.2,   0.4,   0.6 } },
    ['mana_tank_ii']        = { { 0,  2,  3,  4 }, { 0,   0.4,   0.6,   0.8 } },
    ['mana_tank_iii']       = { { 0,  3,  4,  5 }, { 0,   0.6,   0.8,   1.0 } },
    ['mana_tank_iv']        = { { 0,  4,  5,  6 }, { 0,   0.8,   1.0,   1.2 } },
}

local function getRegenModValue(pet, attachmentName, numManeuvers)
    local petMaxHP = pet:getMaxHP()

    return regenRefreshFormulas[attachmentName][1][numManeuvers + 1] + petMaxHP * (regenRefreshFormulas[attachmentName][2][numManeuvers + 1] / 100)
end

local function getRefreshModValue(pet, attachmentName, numManeuvers)
    local petMaxMP = pet:getMaxMP()

    return regenRefreshFormulas[attachmentName][1][numManeuvers + 1] + petMaxMP * (regenRefreshFormulas[attachmentName][2][numManeuvers + 1] / 100)
end

local function isOpticFiber(attachmentName)
    if string.find(attachmentName, 'optic_fiber') ~= nil then
        return true
    end

    return false
end

-- Due to load order, we can't expect to determine Optic Fiber enhancements on change.
-- For maneuvers, calculate this based on the number of light maneuvers that are active.
local function calculatePerformanceBoost(pet)
    local master = pet:getMaster()
    local performanceBoost = 0

    local numLightManeuvers = master and master:countEffect(xi.effect.LIGHT_MANEUVER) or 0
    for _, attachmentObj in ipairs(pet:getAttachments()) do
        local attachmentName = attachmentObj:getName()

        if isOpticFiber(attachmentName) then
            performanceBoost = performanceBoost + attachmentModifiers[attachmentName][1][2][numLightManeuvers + 1]
        end
    end

    return performanceBoost
end

-- Global functions to handle attachment equip, unequip, maneuver and performance changes
-- NOTE: Core is 0-indexed for maneuvers, yet the table above is 1-indexed, and Maneuvers
-- are updated in core before the appropriate function is called in Lua.  This is why some
-- of the functions below have offsets applied.

xi.automaton.onAttachmentEquip = function(pet, attachment)
    xi.automaton.updateAttachmentModifier(pet, attachment, 0)
end

xi.automaton.onAttachmentUnequip = function(pet, attachment)
    local modTable = attachmentModifiers[attachment:getName()]

    for k, modList in ipairs(modTable) do
        if modList[2][1] then
            pet:delMod(modList[1], modList[2][1])
        else
            pet:setMod(modList[1], 0)
        end
    end

    pet:clearLocalVarsWithPrefix(attachment:getName())
end

xi.automaton.onManeuverGain = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

xi.automaton.onManeuverLose = function(pet, attachment, maneuvers)
    xi.automaton.updateAttachmentModifier(pet, attachment, maneuvers)
end

xi.automaton.updateAttachmentModifier = function(pet, attachment, maneuvers)
    local attachmentName = attachment:getName()
    local modTable       = attachmentModifiers[attachmentName]

    for attachmentModPos, modList in ipairs(modTable) do
        local previousMod = pet:getLocalVar(attachmentName .. attachmentModPos)
        local modValue = 0

        -- Local Vars are uint.  In all cases, a negative modifier carries
        -- for all number of maneuvers, so if the last entry is negative,
        -- restore this as a negative value.
        if modList[2][4] and modList[2][4] < 0 then
            previousMod = previousMod * -1
        end

        -- Get base modifier value
        if modList[1] == xi.mod.REGEN then
            modValue = getRegenModValue(pet, attachmentName, maneuvers)
        elseif modList[1] == xi.mod.REFRESH then
            modValue = getRefreshModValue(pet, attachmentName, maneuvers)
        else
            modValue = modList[2][maneuvers + 1]
        end

        -- Apply Automaton Performance Boost if applicable.
        if modList[3] then
            modValue = math.floor(modValue * (1 + calculatePerformanceBoost(pet) / 100))
        end

        if modValue ~= previousMod then
            if previousMod ~= 0 then
                -- If the automaton was reset to a blank state (LEVEL_RESTRICTION)
                -- and the local variables were not cleared, this will under/overflow
                pet:delMod(modList[1], previousMod)
            end

            -- TP Efficiency shouldn't stack, and all values are the same.  This simplify logic to
            -- always set the latest, since there's no difference.
            if modList[1] == xi.mod.AUTO_TP_EFFICIENCY then
                pet:setMod(modList[1], modValue)
            else
                pet:addMod(modList[1], modValue)
            end

            pet:setLocalVar(attachmentName .. attachmentModPos, math.abs(modValue))

            -- If this is an Optic Fiber, there may be other maneuvers and attachments that need to be
            -- updated.
            local master = pet:getMaster()
            if
                master and
                isOpticFiber(attachmentName)
            then
                master:updateAttachments()
            end
        end
    end
end

local function hasAnimatorEquipped(player)
    if
        player:getWeaponSubSkillType(xi.slot.RANGED) == 10 or
        player:getWeaponSubSkillType(xi.slot.RANGED) == 11
    then
        return true
    end

    return false
end

local function getAddBurdenValue(player, maneuverInfo)
    local compareMod = maneuverInfo[3]

    if not compareMod then
        return player:getMP() < player:getPet():getMP() and 15 or 10
    else
        return player:getStat(compareMod) < player:getPet():getStat(compareMod) and 20 or 15
    end
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
    local maneuverInfo = maneuverList[ability:getName()]
    local burdenValue  = getAddBurdenValue(player, maneuverInfo)
    local overload     = target:addBurden(maneuverInfo[2] - 1, burdenValue)

    if
        overload ~= 0 and
        (player:getMod(xi.mod.PREVENT_OVERLOAD) > 0 or player:getPet():getMod(xi.mod.PREVENT_OVERLOAD) > 0) and
        player:delStatusEffectSilent(xi.effect.WATER_MANEUVER)
    then
        overload = 0
    end

    action:messageID(player:getID(), xi.msg.basic.AUTO_OVERLOAD_CHANCE)

    if overload ~= 0 then
        target:removeAllManeuvers()
        target:addStatusEffect(xi.effect.OVERLOAD, 0, 0, overload)
        action:messageID(player:getID(), xi.msg.basic.AUTO_OVERLOADED)
    else
        local pupLevel
        if target:getMainJob() == xi.job.PUP then
            pupLevel = target:getMainLvl()
        else
            pupLevel = target:getSubLvl()
        end

        local bonus = 1 + (pupLevel / 15) + target:getMod(xi.mod.MANEUVER_BONUS)

        if target:getActiveManeuverCount() == 3 then
            target:removeOldestManeuver()
        end

        local duration = player:getPet():getLocalVar('MANEUVER_DURATION')
        target:addStatusEffect(maneuverInfo[1], bonus, 0, utils.clamp(duration, 60, 300))
    end

    return target:getOverloadChance(maneuverInfo[2] - 1)
end
