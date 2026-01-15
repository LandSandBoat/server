-----------------------------------
-- Royale Ramble
-- Balga's Dais KSNM, Lachesis Orb
-- !additem 1178
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.ROYALE_RAMBLE,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        balgasID.mob.KING_OF_CUPS + 6,
        balgasID.mob.KING_OF_CUPS + 13,
        balgasID.mob.KING_OF_CUPS + 20,
    },
})

local function handleDeath(battlefield, mob)
    local baseId = balgasID.mob.KING_OF_CUPS + (battlefield:getArea() - 1) * 7

    for mobId = baseId, baseId + 5 do
        local cardian = GetMobByID(mobId)
        if cardian and cardian:isAlive() then
            return
        end
    end

    content:handleAllMonstersDefeated(battlefield, mob)
end

content.groups =
{
    {
        mobIds =
        {
            {
                balgasID.mob.KING_OF_CUPS,
                balgasID.mob.KING_OF_CUPS + 1,
                balgasID.mob.KING_OF_CUPS + 2,
                balgasID.mob.KING_OF_CUPS + 3,
            },

            {
                balgasID.mob.KING_OF_CUPS + 7,
                balgasID.mob.KING_OF_CUPS + 8,
                balgasID.mob.KING_OF_CUPS + 9,
                balgasID.mob.KING_OF_CUPS + 10,
            },

            {
                balgasID.mob.KING_OF_CUPS + 14,
                balgasID.mob.KING_OF_CUPS + 15,
                balgasID.mob.KING_OF_CUPS + 16,
                balgasID.mob.KING_OF_CUPS + 17,
            },

        },

        death = handleDeath,
    },

    {
        mobIds =
        {
            {
                balgasID.mob.KING_OF_CUPS + 4,
                balgasID.mob.KING_OF_CUPS + 5,
            },

            {
                balgasID.mob.KING_OF_CUPS + 11,
                balgasID.mob.KING_OF_CUPS + 12,
            },

            {
                balgasID.mob.KING_OF_CUPS + 18,
                balgasID.mob.KING_OF_CUPS + 19,
            },
        },

        spawned = false,
        death = handleDeath,
    },
}

content.loot =
{
    {
        { itemId = xi.item.GIL,                        weight = 10000, amount = 24000 },
    },

    {
        { itemId = xi.item.KING_OF_CUPS_CARD,          weight =  2500 },
        { itemId = xi.item.KING_OF_BATONS_CARD,        weight =  2500 },
        { itemId = xi.item.KING_OF_SWORDS_CARD,        weight =  2500 },
        { itemId = xi.item.KING_OF_COINS_CARD,         weight =  2500 },
    },

    {
        { itemId = xi.item.ORICHALCUM_INGOT,           weight = 10000 },
    },

    {
        { itemId = xi.item.COFFINMAKER,                weight =  2500 },
        { itemId = xi.item.DESTROYERS,                 weight =  2500 },
        { itemId = xi.item.DISSECTOR,                  weight =  2500 },
        { itemId = xi.item.GONDO_SHIZUNORI,            weight =  2500 },
    },

    {
        { itemId = xi.item.TRUMP_CROWN,                weight =  6000 },
        { itemId = xi.item.CLAYMORE_GRIP,              weight =  1000 },
        { itemId = xi.item.POLE_GRIP,                  weight =  1000 },
        { itemId = xi.item.SWORD_STRAP,                weight =  2000 },
    },

    {
        { itemId = xi.item.HIERARCH_BELT,              weight =  2500 },
        { itemId = xi.item.PALMERINS_SHIELD,           weight =  2500 },
        { itemId = xi.item.TRAINERS_GLOVES,            weight =  2500 },
        { itemId = xi.item.WARWOLF_BELT,               weight =  2500 },
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,     weight =   500 },
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,          weight =   500 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,       weight =   500 },
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE,      weight =   500 },
        { itemId = xi.item.EBONY_LOG,                  weight =   500 },
        { itemId = xi.item.MAHOGANY_LOG,               weight =   500 },
        { itemId = xi.item.PETRIFIED_LOG,              weight =   500 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =   500 },
        { itemId = xi.item.SPOOL_OF_GOLD_THREAD,       weight =   500 },
        { itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH,    weight =   500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =   500 },
        { itemId = xi.item.CORAL_FRAGMENT,             weight =   500 },
        { itemId = xi.item.DEMON_HORN,                 weight =   500 },
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES,   weight =   500 },
        { itemId = xi.item.RAM_HORN,                   weight =   500 },
        { itemId = xi.item.SLAB_OF_GRANITE,            weight =   500 },
        { itemId = xi.item.RERAISER,                   weight =   500 },
        { itemId = xi.item.HI_RERAISER,                weight =   500 },
        { itemId = xi.item.VILE_ELIXIR,                weight =   500 },
        { itemId = xi.item.VILE_ELIXIR_P1,             weight =   500 },
    },

    {
        { itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD, weight =   625 },
        { itemId = xi.item.SQUARE_OF_DAMASCENE_CLOTH,  weight =   625 },
        { itemId = xi.item.DAMASCUS_INGOT,             weight =   625 },
        { itemId = xi.item.SPOOL_OF_MALBORO_FIBER,     weight =   625 },
        { itemId = xi.item.PHILOSOPHERS_STONE,         weight =  2000 },
        { itemId = xi.item.PHOENIX_FEATHER,            weight =  3500 },
        { itemId = xi.item.SQUARE_OF_RAXA,             weight =  2000 },
    },
}

return content:register()
