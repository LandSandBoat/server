-----------------------------------
-- Let Sleeping Dogs Die
-- Qu'Bia Arena BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.LET_SLEEPING_DOGS_DIE,
    maxPlayers    = 6,
    levelCap      = 30,
    timeLimit     = utils.minutes(30),
    index         = 10,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.SKY_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
})

content:addEssentialMobs({ 'Capelthwaite', 'Freybug', 'Rongeur_Dos', 'Guytrash' })

content.loot =
{
    {
        { item = xi.item.WOLF_HIDE, weight = 1000 },
    },

    {
        { item = xi.item.REVIVAL_TREE_ROOT, weight = 1000 },
    },

    {
        { item = xi.item.NONE,            weight = 100 },
        { item = xi.item.MANNEQUIN_HEAD,  weight = 300 },
        { item = xi.item.MANNEQUIN_BODY,  weight = 300 },
        { item = xi.item.MANNEQUIN_HANDS, weight = 300 },
    },

    {
        { item = xi.item.NONE,                  weight = 250 },
        { item = xi.item.SCROLL_OF_ABSORB_AGI,  weight = 125 },
        { item = xi.item.SCROLL_OF_ABSORB_INT,  weight = 125 },
        { item = xi.item.SCROLL_OF_ABSORB_VIT,  weight = 125 },
        { item = xi.item.SCROLL_OF_ERASE,       weight = 125 },
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI, weight = 125 },
        { item = xi.item.SCROLL_OF_DISPEL,      weight = 125 },
    },

    {
        { item = xi.item.NONE,             weight = 100 },
        { item = xi.item.SINGERS_SHIELD,   weight = 150 },
        { item = xi.item.WARLOCKS_SHIELD,  weight = 150 },
        { item = xi.item.MAGICIANS_SHIELD, weight = 150 },
        { item = xi.item.ASHIGARU_MANTLE,  weight = 150 },
        { item = xi.item.WIZARDS_MANTLE,   weight = 150 },
        { item = xi.item.KILLER_MANTLE,    weight = 150 },
    },
}

return content:register()
