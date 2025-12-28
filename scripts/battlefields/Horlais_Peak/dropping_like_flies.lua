-----------------------------------
-- Dropping Like Flies
-- Horlais Peak BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.DROPPING_LIKE_FLIES,
    maxPlayers       = 6,
    levelCap         = 30,
    timeLimit        = utils.minutes(30),
    index            = 10,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Huntfly', 'Houndfly' })

content.loot =
{
    {
        { itemId = xi.item.GIL,                     weight = 10000, amount = 4000 },
    },

    {
        { itemId = xi.item.INSECT_WING,             weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  6500 },
        { itemId = xi.item.EMPEROR_HAIRPIN,         weight =  3500 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  2500 },
        { itemId = xi.item.ASHIGARU_TARGE,          weight =  2500 },
        { itemId = xi.item.VARLETS_TARGE,           weight =  2500 },
        { itemId = xi.item.WRESTLERS_ASPIS,         weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  2500 },
        { itemId = xi.item.MERCENARY_MANTLE,        weight =  2500 },
        { itemId = xi.item.SINGERS_MANTLE,          weight =  2500 },
        { itemId = xi.item.WIZARDS_MANTLE,          weight =  2500 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  8000 },
        { itemId = xi.item.CHUNK_OF_IRON_ORE,       weight =   200 },
        { itemId = xi.item.CHUNK_OF_SILVER_ORE,     weight =   200 },
        { itemId = xi.item.CHUNK_OF_MYTHRIL_ORE,    weight =   200 },
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight =   200 },
        { itemId = xi.item.IRON_INGOT,              weight =   200 },
        { itemId = xi.item.STEEL_INGOT,             weight =   200 },
        { itemId = xi.item.SILVER_INGOT,            weight =   200 },
        { itemId = xi.item.MYTHRIL_INGOT,           weight =   200 },
        { itemId = xi.item.CHESTNUT_LOG,            weight =   200 },
        { itemId = xi.item.ELM_LOG,                 weight =   200 },
    },

    {
        { itemId = xi.item.SARDONYX,                weight =  1250 },
        { itemId = xi.item.AMBER_STONE,             weight =  1250 },
        { itemId = xi.item.LAPIS_LAZULI,            weight =  1250 },
        { itemId = xi.item.TOURMALINE,              weight =  1250 },
        { itemId = xi.item.CLEAR_TOPAZ,             weight =  1250 },
        { itemId = xi.item.AMETHYST,                weight =  1250 },
        { itemId = xi.item.LIGHT_OPAL,              weight =  1250 },
        { itemId = xi.item.ONYX,                    weight =  1250 },
    },

    {
        { itemId = xi.item.JUG_OF_QUADAV_BUG_BROTH, weight =  5000 },
        { itemId = xi.item.SCROLL_OF_MAGIC_FINALE,  weight =  2000 },
        { itemId = xi.item.SCROLL_OF_DISPEL,        weight =  1000 },
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,   weight =  1000 },
        { itemId = xi.item.SCROLL_OF_ERASE,         weight =  1000 },
    },

    {
        { itemId = xi.item.MANNEQUIN_HEAD,          weight = 10000 },
    },

    {
        { itemId = xi.item.NONE,                    weight =  9000 },
        { itemId = xi.item.MANNEQUIN_BODY,          weight =   500 },
        { itemId = xi.item.PAPILLION,               weight =   500 },
    }
}

return content:register()
