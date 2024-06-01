-----------------------------------
-- Sheep in Antlion's Clothing
-- Boneyard Gully ENM, Miasma Filter
-- !addkeyitem MIASMA_FILTER
-----------------------------------
local boneyardGullyID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BONEYARD_GULLY,
    battlefieldId    = xi.battlefield.id.SHEEP_IN_ANTLIONS_CLOTHING,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = '_081',
    exitNpcs         = { '_082', '_084', '_086' },
    requiredKeyItems = { xi.ki.MIASMA_FILTER },
    armouryCrates    =
    {
        boneyardGullyID.mob.TUCHULCHA + 4,
        boneyardGullyID.mob.TUCHULCHA + 9,
        boneyardGullyID.mob.TUCHULCHA + 14,
    },

    grantXP = 2500,
})

-- TODO: Tuchulcha mob script needs refactoring, and a common method
-- to store these IDs without duplicated code (and _not_ in IDs.lua) is
-- needed.

local antlionPositions =
{
    [1] =
    {
        { -517,    0, -521, 171 },
        { -534,    0, -460, 171 },
        { -552,  2.2, -440, 171 },
        { -572, -3.6, -464, 171 },
        { -573,  2.2, -427, 171 },
        { -562,    0, -484, 171 },
        { -593,    0, -480, 171 },
        { -610, -1.5, -490, 171 },
    },

    [2] =
    {
        {   43,    0,  40, 7 },
        {   26,    0, 100, 7 },
        {    7,  2.2, 118, 7 },
        {  -13, -3.6,  95, 7 },
        {  -13,  2.2, 133, 7 },
        { -2.3,    0,  76, 7 },
        {  -33,    0,  79, 7 },
        {  -54, -1.5,  67, 7 },
    },

    [3] =
    {
        { 522,    0, 521, 240 },
        { 506,    0, 580, 240 },
        { 466,  2.2, 614, 240 },
        { 467, -3.6,  57, 240 },
        { 488,  2.2, 598, 240 },
        { 478,    0, 557, 240 },
        { 446,    0, 558, 240 },
        { 430, -1.5, 550, 240 },
    },
}

function content:setupBattlefield(battlefield)
    local battlefieldArea   = battlefield:getArea()
    local selectedPositions = utils.permgen(#antlionPositions[battlefieldArea])

    -- Set the Hunter Spawn locations
    for mobNum = 1, 3 do
        GetMobByID(content.groups[2].mobIds[battlefieldArea][mobNum]):setPos(antlionPositions[battlefieldArea][selectedPositions[mobNum]])
    end

    -- Select Tuchulcha's sandpit positions
    local tuchulcha = GetMobByID(content.groups[1].mobIds[battlefieldArea][1])
    tuchulcha:setLocalVar('sand_pit1', selectedPositions[4])
    tuchulcha:setLocalVar('sand_pit2', selectedPositions[5])
    tuchulcha:setLocalVar('sand_pit3', selectedPositions[6])
    tuchulcha:setPos(antlionPositions[battlefieldArea][selectedPositions[7]])
end

content.groups =
{
    {
        mobIds =
        {
            { boneyardGullyID.mob.TUCHULCHA     },
            { boneyardGullyID.mob.TUCHULCHA + 4 },
            { boneyardGullyID.mob.TUCHULCHA + 8 },
        },

        superlink = false,
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            {
                boneyardGullyID.mob.TUCHULCHA + 1,
                boneyardGullyID.mob.TUCHULCHA + 2,
                boneyardGullyID.mob.TUCHULCHA + 3,
            },

            {
                boneyardGullyID.mob.TUCHULCHA + 5,
                boneyardGullyID.mob.TUCHULCHA + 6,
                boneyardGullyID.mob.TUCHULCHA + 7,
            },

            {
                boneyardGullyID.mob.TUCHULCHA + 9,
                boneyardGullyID.mob.TUCHULCHA + 10,
                boneyardGullyID.mob.TUCHULCHA + 11,
            },
        },

        superlink = false,
    },
}

content.loot =
{
    {
        { item = xi.item.SQUARE_OF_GALATEIA,     weight = 268 },  -- Square of Galateia (26.8% Drop Rate)
        { item = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 266 },  -- Kejusu Satin
        { item = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 342 },  -- Viridian Urushi
    },

    {
        { item = xi.item.NONE,         weight = 944 }, -- nothing
        { item = xi.item.CLOUD_EVOKER, weight =  56 }, -- Cloud Evoker
    },

    {
        { item = xi.item.HAGUN,            weight =  82 }, -- Hagun
        { item = xi.item.MARTIAL_AXE,      weight =  92 }, -- Martial Axe
        { item = xi.item.MARTIAL_WAND,     weight =  63 }, -- Martial Wand
        { item = xi.item.FORAGERS_MANTLE,  weight = 105 }, -- Forager's Mantle
        { item = xi.item.HARMONIAS_TORQUE, weight = 121 }, -- Harmonia's Torque
    },
}

return content:register()
