-----------------------------------
--  Automaton Global
-----------------------------------
xi = xi or {}
xi.automaton = {}

-- This table contains modifiers granted by attachments based on maneuver.  It uses
-- full values per maneuver, and should not be additive unless the mod is granted by
-- a separate attachment.  Therefore, when adding or removing these, subtract the
-- previous value if it exists, and then add or delete the result.

-- TODO: Make sure we handle optic fiber add/del correctly
local attachmentModifiers =
{
--                                                                  Num. Maneuvers
--  Attachment                 Modifier                             0,   1,     2,    3
    ['accelerator']        = { { xi.mod.EVA,                    {   5,   10,   15,   20 } }, },
    ['accelerator_ii']     = { { xi.mod.EVA,                    {  10,   15,   20,   25 } }, },
    ['accelerator_iii']    = { { xi.mod.EVA,                    {  20,   30,   40,   50 } }, },
    ['accelerator_iv']     = { { xi.mod.EVA,                    {  30,   45,   60,   80 } }, },
    ['analyzer']           = { { xi.mod.AUTO_ANALYZER,          {   1,    2,    4,    6 } }, },
    ['arcanic_cell']       = { { xi.mod.OCCULT_ACUMEN,          {  10,   20,   35,   50 } }, },
    ['arcanic_cell_ii']    = { { xi.mod.OCCULT_ACUMEN,          {  20,   40,   70,  100 } }, },
    ['arcanoclutch']       = { { xi.mod.MAGIC_DAMAGE,           {  20,   40,   60,   80 } }, },
    ['arcanoclutch_ii']    = { { xi.mod.MAGIC_DAMAGE,           {  40,   60,   80,  120 } }, },
    ['armor_plate']        = { { xi.mod.DMGPHYS,                {  -5,   -7,  -10,  -15 } }, },
    ['armor_plate_ii']     = { { xi.mod.DMGPHYS,                { -10,  -15,  -20,  -25 } }, },
    ['armor_plate_iii']    = { { xi.mod.DMGPHYS,                { -15,  -20,  -25,  -30 } }, },
    ['armor_plate_iv']     = { { xi.mod.DMGPHYS,                { -20,  -25,  -30,  -40 } }, },
    ['coiler']             = { { xi.mod.DOUBLE_ATTACK,          {   3,   10,   20,   30 } }, },
    ['coiler_ii']          = { { xi.mod.DOUBLE_ATTACK,          {  10,   15,   25,   35 } }, },
    ['dynamo']             = { { xi.mod.CRITHITRATE,            {   3,    5,    7,    9 } }, },
    ['dynamo_ii']          = { { xi.mod.CRITHITRATE,            {   5,   10,   15,   20 } }, },
    ['dynamo_iii']         = { { xi.mod.CRITHITRATE,            {  10,   15,   25,   35 } }, },
    ['equalizer']          = { { xi.mod.AUTO_EQUALIZER,         {  10,   25,   50,   75 } }, },
    ['galvanizer']         = { { xi.mod.COUNTER,                {  10,   20,   35,   50 } }, },
    ['heatsink']           = { { xi.mod.BURDEN_DECAY,           {   2,    4,    5,    6 } }, },
    ['inhibitor']          = { { xi.mod.STORETP,                {   5,   15,   25,   40 } },
                               { xi.mod.AUTO_TP_EFFICIENCY,     { 900,  900,  900,  900 } }, },
    ['inhibitor_ii']       = { { xi.mod.STORETP,                {  10,   25,   40,   65 } },
                               { xi.mod.AUTO_TP_EFFICIENCY,     { 900,  900,  900,  900 } }, },
    ['loudspeaker']        = { { xi.mod.MATT,                   {   5,   10,   15,   20 } }, },
    ['loudspeaker_ii']     = { { xi.mod.MATT,                   {  10,   15,   20,   25 } }, },
    ['loudspeaker_iii']    = { { xi.mod.MATT,                   {  20,   30,   40,   50 } }, },
    ['loudspeaker_iv']     = { { xi.mod.MATT,                   {  30,   40,   50,   60 } }, },
    ['mana_booster']       = { { xi.mod.AUTO_MAGIC_DELAY,       {   2,    4,    6,    8 } }, },
    ['mana_conserver']     = { { xi.mod.CONSERVE_MP,            {  15,   30,   45,   60 } }, },
    ['mana_jammer']        = { { xi.mod.MDEF,                   {  10,   20,   30,   40 } }, },
    ['mana_jammer_ii']     = { { xi.mod.MDEF,                   {  20,   30,   40,   50 } }, },
    ['mana_jammer_iii']    = { { xi.mod.MDEF,                   {  30,   40,   50,   60 } }, },
    ['mana_jammer_iv']     = { { xi.mod.MDEF,                   {  40,   50,   60,   70 } }, },
    ['optic_fiber']        = { { xi.mod.AUTO_PERFORMANCE_BOOST, {  10,   20,   25,   30 } }, },
    ['optic_fiber_ii']     = { { xi.mod.AUTO_PERFORMANCE_BOOST, {  15,   30,   37,   45 } }, },
    ['percolator']         = { { xi.mod.COMBAT_SKILLUP_RATE,    {   5,   10,   15,   20 } }, },
    ['repeater']           = { { xi.mod.DOUBLE_SHOT_RATE,       {  10,   15,   35,   65 } }, },
    ['scanner']            = { { xi.mod.AUTO_SCAN_RESISTS,      {   0,    1,    1,    1 } }, },
    ['schurzen']           = { { xi.mod.AUTO_SCHURZEN,          {   0,    1,    1,    1 } }, },
    ['scope']              = { { xi.mod.RACC,                   {  10,   20,   30,   40 } }, },
    ['scope_ii']           = { { xi.mod.RACC,                   {  20,   30,   40,   50 } }, },
    ['scope_iii']          = { { xi.mod.RACC,                   {  30,   40,   55,   70 } }, },
    ['stabilizer']         = { { xi.mod.ACC,                    {   5,   10,   15,   20 } }, },
    ['stabilizer_ii']      = { { xi.mod.ACC,                    {  10,   15,   20,   25 } }, },
    ['stabilizer_iii']     = { { xi.mod.ACC,                    {  20,   30,   40,   50 } }, },
    ['stabilizer_iv']      = { { xi.mod.ACC,                    {  30,   40,   55,   70 } }, },
    ['stealth_screen']     = { { xi.mod.ENMITY,                 { -10,  -20,  -30,  -40 } }, },
    ['stealth_screen_ii']  = { { xi.mod.ENMITY,                 { -15,  -25,  -35,  -45 } }, },
    ['strobe']             = { { xi.mod.ENMITY,                 {  10,   25,   40,   60 } }, },
    ['strobe_ii']          = { { xi.mod.ENMITY,                 {  20,   40,   65,  100 } }, },
    ['tactical_processor'] = { { xi.mod.AUTO_DECISION_DELAY,    {  50,   70,   85,  115 } }, },
    ['tension_spring']     = { { xi.mod.ATTP,                   {   3,    6,    9,   12 } },
                               { xi.mod.RATTP,                  {   3,    6,    9,   12 } }, },
    ['tension_spring_ii']  = { { xi.mod.ATTP,                   {   6,    9,   12,   15 } },
                               { xi.mod.RATTP,                  {   6,    9,   12,   15 } }, },
    ['tension_spring_iii'] = { { xi.mod.ATTP,                   {  12,   15,   18,   21 } },
                               { xi.mod.RATTP,                  {  12,   15,   18,   21 } }, },
    ['tension_spring_iv']  = { { xi.mod.ATTP,                   {  15,   18,   21,   24 } },
                               { xi.mod.RATTP,                  {  15,   18,   21,   24 } }, },
    ['tension_spring_v']   = { { xi.mod.ATTP,                   {  18,   21,   24,   27 } },
                               { xi.mod.RATTP,                  {  18,   21,   24,   27 } }, },
    ['tranquilizer']       = { { xi.mod.MACC,                   {  10,   30,   40,   50 } }, },
    ['tranquilizer_ii']    = { { xi.mod.MACC,                   {  20,   40,   55,   70 } }, },
    ['tranquilizer_iii']   = { { xi.mod.MACC,                   {  30,   50,   70,   80 } }, },
    ['turbo_charger']      = { { xi.mod.HASTE_MAGIC,            { 500, 1500, 2000, 2500 } }, },
    ['turbo_charger_ii']   = { { xi.mod.HASTE_MAGIC,            { 700, 1700, 2800, 4375 } }, },
    ['vivi-valve']         = { { xi.mod.CURE_POTENCY,           {   5,   15,   30,   45 } }, },
    ['vivi-valve_ii']      = { { xi.mod.CURE_POTENCY,           {  10,   20,   35,   50 } }, },
}

-- Global functions to handle attachment equip, unequip, maneuver and performance changes
--
-- modTable       : Full table returned from a specific attachment indexed above
-- modTable[k][1] : Modifier to be applied
-- modTable[k][2] : Modifier value based on number of Maneuvers
--
-- NOTE: Core is 0-indexed for maneuvers, yet the table above is 1-indexed, and Maneuvers
-- are updated in core before the appropriate function is called in Lua.  This is why some
-- of the functions below have offsets applied.
-- 
-- TODO: Factor in AUTO_PERFORMANCE_BOOST into these functions
xi.automaton.onAttachmentEquip = function(pet, attachment)
    local modTable = attachmentModifiers[attachment:getName()]

    for k, _ in ipairs(modTable) do
        printf("Adding Mod %d : %d", modTable[k][1], modTable[k][2][1])
        pet:addMod(modTable[k][1], modTable[k][2][1])
    end
end

xi.automaton.onAttachmentUnequip = function(pet, attachment)
    local modTable = attachmentModifiers[attachment:getName()]

    for k, _ in ipairs(modTable) do
        printf("Deleting Mod %d : %d", modTable[k][1], modTable[k][2][1])
        pet:delMod(modTable[k][1], modTable[k][2][1])
    end
end

xi.automaton.onManeuverGain = function(pet, attachment, maneuvers)
    local modTable = attachmentModifiers[attachment:getName()]

    for k, _ in ipairs(modTable) do
        printf("Deleting Mod %d (%d), and replacing with %d", modTable[k][1], modTable[k][2][maneuvers], modTable[k][2][maneuvers + 1])
        pet:delMod(modTable[k][1], modTable[k][2][maneuvers])
        pet:addMod(modTable[k][1], modTable[k][2][maneuvers + 1])
    end
end

xi.automaton.onManeuverLose = function(pet, attachment, maneuvers)
    local modTable = attachmentModifiers[attachment:getName()]

    for k, _ in ipairs(modTable) do
        printf("Deleting Mod %d (%d), and replacing with %d", modTable[k][1], modTable[k][2][maneuvers + 2], modTable[k][2][maneuvers + 1])
        pet:delMod(modTable[k][1], modTable[k][2][maneuvers + 2])
        pet:addMod(modTable[k][1], modTable[k][2][maneuvers + 1])
    end
end

xi.automaton.updateAttachmentModifier = function(pet, attachment, maneuvers)
    local attachmentKey = attachment:getName()
    local modTable = attachmentModifiers[attachmentKey]

    for k, v in ipairs(modTable) do
        printf("We should be at %d : %d", modTable[k][1], modTable[k][2][maneuvers + 1])
    end

    print(attachmentKey)
    print(maneuvers)
end

-- Legacy Function while some attachments are still updated
xi.automaton.updateModPerformance = function(pet, mod, key, value, cap)
    local previous = pet:getLocalVar(key)

    if previous ~= 0 then
        pet:delMod(mod, previous)
    end

    value = value + value * (pet:getMod(xi.mod.AUTO_PERFORMANCE_BOOST) / 100)

    if cap then
        value = math.min(value, cap)
    end

    pet:addMod(mod, value)
    pet:setLocalVar(key, value)
end
