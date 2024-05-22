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
        { item = xi.item.GIL, weight = 1000, amount = 4000 }, -- Gil
    },

    {
        { item = xi.item.INSECT_WING, weight = 1000 }, -- Insect Wing
    },

    {
        { item = xi.item.MANNEQUIN_HEAD, weight = 1000 }, -- Mannequin Head
    },

    {
        { item = xi.item.NONE,            weight = 636 }, -- Nothing
        { item = xi.item.EMPEROR_HAIRPIN, weight = 364 }, -- Emperor Hairpin
    },

    {
        { item = xi.item.ASHIGARU_TARGE,  weight = 175 }, -- Ashigaru Targe
        { item = xi.item.BEATERS_ASPIS,   weight = 175 }, -- Beaters Aspis
        { item = xi.item.VARLETS_TARGE,   weight = 175 }, -- Varlets Targe
        { item = xi.item.WRESTLERS_ASPIS, weight = 175 }, -- Wrestlers Aspis
        { item = xi.item.CLEAR_TOPAZ,     weight = 100 }, -- Clear Topaz
        { item = xi.item.LAPIS_LAZULI,    weight = 100 }, -- Lapis Lazuli
        { item = xi.item.LIGHT_OPAL,      weight = 100 }, -- Light Opal
    },

    {
        { item = xi.item.MERCENARY_MANTLE, weight = 250 }, -- Mercenary Mantle
        { item = xi.item.SINGERS_MANTLE,   weight = 250 }, -- Singers Mantle
        { item = xi.item.WIZARDS_MANTLE,   weight = 250 }, -- Wizards Mantle
        { item = xi.item.WYVERN_MANTLE,    weight = 250 }, -- Wyvern Mantle
    },

    {
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,   weight =  70 }, -- Scroll Of Utsusemi Ni
        { item = xi.item.SCROLL_OF_MAGIC_FINALE,  weight =  70 }, -- Scroll Of Magic Finale
        { item = xi.item.JUG_OF_QUADAV_BUG_BROTH, weight = 150 }, -- Jug Of Quadav Bug Broth
        { item = xi.item.ONYX,                    weight = 100 }, -- Onyx
        { item = xi.item.LAPIS_LAZULI,            weight = 100 }, -- Lapis Lazuli
        { item = xi.item.LIGHT_OPAL,              weight = 100 }, -- Light Opal
        { item = xi.item.SCROLL_OF_DISPEL,        weight = 150 }, -- Scroll Of Dispel
        { item = xi.item.SCROLL_OF_ERASE,         weight = 100 }, -- Scroll Of Erase
        { item = xi.item.ELM_LOG,                 weight =  90 }, -- Elm Log
        { item = xi.item.MANNEQUIN_BODY,          weight =  70 }, -- Mannequin Body
    },
}

return content:register()
