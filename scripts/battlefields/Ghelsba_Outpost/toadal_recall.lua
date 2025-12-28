-----------------------------------
-- Toadal Recall
-- Ghelsba Outpost BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local ghelsbaID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.GHELSBA_OUTPOST,
    battlefieldId    = xi.battlefield.id.TOADAL_RECALL,
    maxPlayers       = 6,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 4,
    area             = 1,
    entryNpc         = 'Hut_Door',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = ghelsbaID.text.A_CRACK_HAS_FORMED, wornMessage = ghelsbaID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        ghelsbaID.mob.TOADPILLOW + 4,
    },
})

content:addEssentialMobs({ 'Toadpillow', 'Toadsquab', 'Toadbolster', 'Toadcushion' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                    weight = 10000, amount = 4000 },
    },

    {
        { itemId = xi.item.KING_TRUFFLE,           weight =  2500 },
        { itemId = xi.item.WOOZYSHROOM,            weight =  2500 },
        { itemId = xi.item.DANCESHROOM,            weight =  2500 },
        { itemId = xi.item.SLEEPSHROOM,            weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  2500 },
        { itemId = xi.item.MERCENARYS_TARGE,       weight =  2500 },
        { itemId = xi.item.BEATERS_ASPIS,          weight =  2500 },
        { itemId = xi.item.PILFERERS_ASPIS,        weight =  2500 },
    },

        {
        { itemId = xi.item.NONE,                   weight =  2500 },
        { itemId = xi.item.TRIMMERS_MANTLE,        weight =  2500 },
        { itemId = xi.item.GENIN_MANTLE,           weight =  2500 },
        { itemId = xi.item.WARLOCKS_MANTLE,        weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  8000 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =   200 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =   200 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =   200 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =   200 },
        { itemId = xi.item.IRON_INGOT,             weight =   200 },
        { itemId = xi.item.STEEL_INGOT,            weight =   200 },
        { itemId = xi.item.SILVER_INGOT,           weight =   200 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =   200 },
        { itemId = xi.item.CHESTNUT_LOG,           weight =   200 },
        { itemId = xi.item.ELM_LOG,                weight =   200 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  5000 },
        { itemId = xi.item.KING_TRUFFLE,           weight =  1250 },
        { itemId = xi.item.WOOZYSHROOM,            weight =  1250 },
        { itemId = xi.item.DANCESHROOM,            weight =  1250 },
        { itemId = xi.item.SLEEPSHROOM,            weight =  1250 },
    },

    {
        { itemId = xi.item.NONE,                   weight =  1000 },
        { itemId = xi.item.MANNEQUIN_HEAD,         weight =  3000 },
        { itemId = xi.item.MANNEQUIN_BODY,         weight =  3000 },
        { itemId = xi.item.MANNEQUIN_HANDS,        weight =  3000 },
    },
}

return content:register()
