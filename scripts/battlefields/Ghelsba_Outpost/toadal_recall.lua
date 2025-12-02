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
        { itemId = xi.item.GIL,                    weight = 1000, amount = 4000 },
    },

    {
        { itemId = xi.item.KING_TRUFFLE,           weight = 250 },
        { itemId = xi.item.WOOZYSHROOM,            weight = 250 },
        { itemId = xi.item.DANCESHROOM,            weight = 250 },
        { itemId = xi.item.SLEEPSHROOM,            weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.MERCENARYS_TARGE,       weight = 250 },
        { itemId = xi.item.BEATERS_ASPIS,          weight = 250 },
        { itemId = xi.item.PILFERERS_ASPIS,        weight = 250 },
    },

        {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.TRIMMERS_MANTLE,        weight = 250 },
        { itemId = xi.item.GENIN_MANTLE,           weight = 250 },
        { itemId = xi.item.WARLOCKS_MANTLE,        weight = 250 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 800 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,      weight =  20 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,    weight =  20 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,   weight =  20 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE, weight =  20 },
        { itemId = xi.item.IRON_INGOT,             weight =  20 },
        { itemId = xi.item.STEEL_INGOT,            weight =  20 },
        { itemId = xi.item.SILVER_INGOT,           weight =  20 },
        { itemId = xi.item.MYTHRIL_INGOT,          weight =  20 },
        { itemId = xi.item.CHESTNUT_LOG,           weight =  20 },
        { itemId = xi.item.ELM_LOG,                weight =  20 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 500 },
        { itemId = xi.item.KING_TRUFFLE,           weight = 125 },
        { itemId = xi.item.WOOZYSHROOM,            weight = 125 },
        { itemId = xi.item.DANCESHROOM,            weight = 125 },
        { itemId = xi.item.SLEEPSHROOM,            weight = 125 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 100 },
        { itemId = xi.item.MANNEQUIN_HEAD,         weight = 300 },
        { itemId = xi.item.MANNEQUIN_BODY,         weight = 300 },
        { itemId = xi.item.MANNEQUIN_HANDS,        weight = 300 },
    },
}

return content:register()
