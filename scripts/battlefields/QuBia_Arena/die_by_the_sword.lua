-----------------------------------
-- Die by the Sword
-- Qu'Bia Arena BCNM30, Sky Orb
-- !additem 1552
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.DIE_BY_THE_SWORD,
    maxPlayers       = 3,
    levelCap         = 30,
    timeLimit        = utils.minutes(15),
    index            = 9,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.SKY_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },

    experimental = true,
})

content:addEssentialMobs({ 'Gladiatorial_Weapon' })

content.loot =
{
    {
        { item = xi.item.RUSTY_PICK, weight = 1000 }, -- rusty_pick
    },

    {
        { item = xi.item.ASHIGARU_EARRING,   weight = 71 }, -- ashigaru_earring
        { item = xi.item.ESQUIRES_EARRING,   weight = 71 }, -- esquires_earring
        { item = xi.item.MAGICIANS_EARRING,  weight = 72 }, -- magicians_earring
        { item = xi.item.MERCENARYS_EARRING, weight = 72 }, -- mercenarys_earring
        { item = xi.item.PILFERERS_EARRING,  weight = 72 }, -- pilferers_earring
        { item = xi.item.SINGERS_EARRING,    weight = 71 }, -- singers_earring
        { item = xi.item.TRIMMERS_EARRING,   weight = 71 }, -- trimmers_earring
        { item = xi.item.WARLOCKS_EARRING,   weight = 72 }, -- warlocks_earring
        { item = xi.item.WIZARDS_EARRING,    weight = 72 }, -- wizards_earring
        { item = xi.item.WRESTLERS_EARRING,  weight = 72 }, -- wrestlers_earring
        { item = xi.item.WYVERN_EARRING,     weight = 71 }, -- wyvern_earring
        { item = xi.item.BEATERS_EARRING,    weight = 71 }, -- beaters_earring
        { item = xi.item.GENIN_EARRING,      weight = 71 }, -- genin_earring
        { item = xi.item.KILLER_EARRING,     weight = 71 }, -- killer_earring
    },

    {
        { item = xi.item.AVATAR_BELT, weight = 71 }, -- avatar_belt
        { item = xi.item.AXE_BELT,    weight = 71 }, -- axe_belt
        { item = xi.item.CESTUS_BELT, weight = 72 }, -- cestus_belt
        { item = xi.item.DAGGER_BELT, weight = 72 }, -- dagger_belt
        { item = xi.item.GUN_BELT,    weight = 72 }, -- gun_belt
        { item = xi.item.KATANA_OBI,  weight = 71 }, -- katana_obi
        { item = xi.item.LANCE_BELT,  weight = 71 }, -- lance_belt
        { item = xi.item.SARASHI,     weight = 72 }, -- sarashi
        { item = xi.item.SCYTHE_BELT, weight = 72 }, -- scythe_belt
        { item = xi.item.SHIELD_BELT, weight = 72 }, -- shield_belt
        { item = xi.item.SONG_BELT,   weight = 71 }, -- song_belt
        { item = xi.item.STAFF_BELT,  weight = 71 }, -- staff_belt
        { item = xi.item.PICK_BELT,   weight = 71 }, -- pick_belt
        { item = xi.item.RAPIER_BELT, weight = 71 }, -- rapier_belt
    },

    {
        { item = xi.item.SCROLL_OF_ERASE,        weight = 200 }, -- scroll_of_erase
        { item = xi.item.SCROLL_OF_REPRISAL,     weight = 200 }, -- scroll_of_reprisal
        { item = xi.item.SCROLL_OF_DISPEL,       weight = 200 }, -- scroll_of_dispel
        { item = xi.item.SCROLL_OF_MAGIC_FINALE, weight = 200 }, -- scroll_of_magic_finale
        { item = xi.item.SCROLL_OF_UTSUSEMI_NI,  weight = 200 }, -- gscroll_of_utsusemi_nin_belt
    },

    {
        { item = xi.item.NONE,             weight = 775 }, -- nothing
        { item = xi.item.GOLD_INGOT,       weight =  50 }, -- gold_ingot
        { item = xi.item.PLATINUM_INGOT,   weight =  50 }, -- platinum_ingot
        { item = xi.item.PETRIFIED_LOG,    weight =  50 }, -- petrified_log
        { item = xi.item.RUSTY_GREATSWORD, weight =  75 }, -- rusty_greatsword
    },

    {
        { item = xi.item.NONE,            weight = 250 }, -- nothing
        { item = xi.item.MANNEQUIN_HEAD,  weight = 250 }, -- mannequin_head
        { item = xi.item.MANNEQUIN_BODY,  weight = 250 }, -- mannequin_body
        { item = xi.item.MANNEQUIN_HANDS, weight = 250 }, -- mannequin_hands
    },

    {
        { item = xi.item.NONE,     weight = 667 }, -- nothing
        { item = xi.item.HI_ETHER, weight = 333 }, -- hi-ether
    },
}

return content:register()
