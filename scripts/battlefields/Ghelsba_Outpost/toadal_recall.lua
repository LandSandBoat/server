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

-- TODO: Shroom-in-Cap Mechanic
content:addEssentialMobs({ 'Toadpillow', 'Toadsquab', 'Toadbolster', 'Toadcushion' })

content.loot =
{
    {
        { itemId = xi.item.KING_TRUFFLE, weight = 1000 }, -- king_truffle
    },

    {
        { itemId = xi.item.JUG_OF_SEEDBED_SOIL, weight = 1000 }, -- jug_of_seedbed_soil
    },

    {
        { itemId = xi.item.NONE,             weight = 200 }, -- nothing
        { itemId = xi.item.MAGICIANS_SHIELD, weight = 200 }, -- magicians_shield
        { itemId = xi.item.MERCENARYS_TARGE, weight = 200 }, -- mercenarys_targe
        { itemId = xi.item.BEATERS_ASPIS,    weight = 200 }, -- beaters_aspis
        { itemId = xi.item.PILFERERS_ASPIS,  weight = 200 }, -- pilferers_aspis
    },

    {
        { itemId = xi.item.NONE,            weight = 250 }, -- nothing
        { itemId = xi.item.TRIMMERS_MANTLE, weight = 250 }, -- trimmers_mantle
        { itemId = xi.item.GENIN_MANTLE,    weight = 250 }, -- genin_mantle
        { itemId = xi.item.WARLOCKS_MANTLE, weight = 250 }, -- warlocks_mantle
    },

    {
        { itemId = xi.item.NONE,                  weight = 625 }, -- nothing
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 125 }, -- scroll_of_utsusemi_ni
        { itemId = xi.item.SCROLL_OF_PHALANX,     weight = 125 }, -- scroll_of_phalanx
        { itemId = xi.item.SCROLL_OF_ERASE,       weight = 125 }, -- scroll_of_erase
    },

    {
        { itemId = xi.item.NONE,            weight = 250 }, -- nothing
        { itemId = xi.item.MANNEQUIN_HEAD,  weight = 250 }, -- mannequin_head
        { itemId = xi.item.MANNEQUIN_BODY,  weight = 250 }, -- mannequin_body
        { itemId = xi.item.MANNEQUIN_HANDS, weight = 250 }, -- mannequin_hands
    },
}

return content:register()
