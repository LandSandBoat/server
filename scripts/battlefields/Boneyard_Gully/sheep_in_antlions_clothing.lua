-----------------------------------
-- Sheep in Antlion's Clothing
-- Boneyard Gully ENM (Miasma Filter)
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
        boneyardGullyID.mob.TUCHULCHA + 10,
        boneyardGullyID.mob.TUCHULCHA + 16,
    },
    grantXP = 2500,
})

content.groups =
{
    {
        mobIds =
        {
            { boneyardGullyID.mob.TUCHULCHA      },
            { boneyardGullyID.mob.TUCHULCHA + 6  },
            { boneyardGullyID.mob.TUCHULCHA + 12 },
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
                boneyardGullyID.mob.TUCHULCHA + 7,
                boneyardGullyID.mob.TUCHULCHA + 8,
                boneyardGullyID.mob.TUCHULCHA + 9,
            },
            {
                boneyardGullyID.mob.TUCHULCHA + 13,
                boneyardGullyID.mob.TUCHULCHA + 14,
                boneyardGullyID.mob.TUCHULCHA + 15,
            },
        },
        superlink = false,
    },
}

-- Possible Swift, Armored, and Shrewd Hunter Antlion spawn positions as well as possible Sandpit locations for Tuchulcha.
local antlionPositions =
{
    [1] =
    {
        { -516,  0.0, -517, 171 },
        { -533,  0.2, -460, 171 },
        { -552,  2.2, -440, 171 },
        { -570, -3.6, -464, 171 },
        { -589,  0.2, -484, 171 },
        { -527,  0.2, -471, 171 },
        { -530,  0.3, -478, 171 },
        { -574,  0.6, -478, 171 },
        { -560,  0.0, -476, 171 },
        { -596,  0.2, -478, 171 },
        { -570,  3.0, -433, 171 },
    },

    [2] =
    {
        { 43,  0.0,  40, 7 },
        { 27,  0.2,  99, 7 },
        { 7,   2.2, 117, 7 },
        { -11, 3.4,  96, 7 },
        { -30, 0.2,  76, 7 },
        { 32,  0.2,  89, 7 },
        { 29,  0.3,  82, 7 },
        { -15, 0.6,  82, 7 },
        { -1,  0.0,  84, 7 },
        { -37, 0.2,  82, 7 },
        { -11, 3.0, 127, 7 },
    },

    [3] =
    {
        { 522,  0.0, 528, 240 },
        { 505,  0.2, 585, 240 },
        { 486,  2.2, 605, 240 },
        { 468,  3.4, 575, 240 },
        { 449,  0.2, 555, 240 },
        { 511,  0.2, 568, 240 },
        { 508,  0.3, 561, 240 },
        { 464,  0.6, 561, 240 },
        { 478,  0.0, 563, 240 },
        { 442,  0.2, 561, 240 },
        { 468,  3.0, 606, 240 },
    },
}

function content:setupBattlefield(battlefield)
    local area = battlefield:getArea()
    local positions = antlionPositions[area]
    if not positions then
        return
    end

    -- Using the permgen utility to generate a random order of unique indices.
    local order = utils.permgen(#positions)

    -- Assign positions to the Swift, Armored, and Shrewd Antlions
    for i = 1, 3 do
        local mob = GetMobByID(content.groups[2].mobIds[area][i])
        if mob then
            mob:setPos(unpack(positions[order[i]]))
        end
    end

    -- Assign 3 unique sandpit destinations for Tuchulcha
    local tuchulcha = GetMobByID(content.groups[1].mobIds[area][1])
    if tuchulcha then
        tuchulcha:setLocalVar('sand_pit1', order[4])
        tuchulcha:setLocalVar('sand_pit2', order[5])
        tuchulcha:setLocalVar('sand_pit3', order[6])
    end
end

content.loot =
{
    {
        { itemId = xi.item.NONE,                   weight = 950 },
        { itemId = xi.item.CLOUD_EVOKER,           weight =  50 },
    },
    {
        { itemId = xi.item.NONE,                   weight = 150 },
        { itemId = xi.item.SQUARE_OF_GALATEIA,     weight = 250 },
        { itemId = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 250 },
        { itemId = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 350 },
    },
    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 735 },
        { itemId = xi.item.HAGUN,                  weight =  45 },
        { itemId = xi.item.MARTIAL_AXE,            weight =  45 },
        { itemId = xi.item.MARTIAL_WAND,           weight =  45 },
        { itemId = xi.item.FORAGERS_MANTLE,        weight =  65 },
        { itemId = xi.item.HARMONIAS_TORQUE,       weight =  65 },
    },
}

return content:register()
