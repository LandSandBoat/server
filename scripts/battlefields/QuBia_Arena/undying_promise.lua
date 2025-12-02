-----------------------------------
-- Undying Promise
-- Qu'Bia Arena BCNM40, Star Orb
-- !additem 1131
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.UNDYING_PROMISE,
    maxPlayers    = 6,
    levelCap      = 40,
    timeLimit     = utils.minutes(15),
    index         = 12,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.STAR_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
    armouryCrates =
    {
        qubiaID.mob.GHUL_I_BEABAN + 2,
        qubiaID.mob.GHUL_I_BEABAN + 5,
        qubiaID.mob.GHUL_I_BEABAN + 8,
    },
})

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.GHUL_I_BEABAN     },
            { qubiaID.mob.GHUL_I_BEABAN + 3 },
            { qubiaID.mob.GHUL_I_BEABAN + 6 },
        },
    },

    {
        mobIds =
        {
            { qubiaID.mob.GHUL_I_BEABAN + 1 },
            { qubiaID.mob.GHUL_I_BEABAN + 4 },
            { qubiaID.mob.GHUL_I_BEABAN + 7 },
        },

        death = function(battlefield, mob)
            if mob:getLocalVar('numReraises') == 4 then
                content:handleAllMonstersDefeated(battlefield, mob)
            end
        end,

        spawned = false,
    },
}

content.loot =
{
    {
        quantity = 2,
        { itemId = xi.item.BONE_CHIP, weight = 1000 }, -- bone_chip
    },

    {
        { itemId = xi.item.CALVELEYS_DAGGER, weight = 175 }, -- calveleys_dagger
        { itemId = xi.item.JENNET_SHIELD,    weight = 175 }, -- jennet_shield
        { itemId = xi.item.JONGLEURS_DAGGER, weight = 175 }, -- jongleurs_dagger
        { itemId = xi.item.KAGEHIDE,         weight = 175 }, -- kagehide
        { itemId = xi.item.OHAGURO,          weight = 175 }, -- ohaguro
        { itemId = xi.item.EBONY_LOG,        weight = 125 }, -- ebony_log
    },

    {
        { itemId = xi.item.BEHOURD_LANCE,  weight = 200 }, -- behourd_lance
        { itemId = xi.item.ELEGANT_SHIELD, weight = 200 }, -- elegant_shield
        { itemId = xi.item.MUTILATOR,      weight = 200 }, -- mutilator
        { itemId = xi.item.RAIFU,          weight = 200 }, -- raifu
        { itemId = xi.item.TOURNEY_PATAS,  weight = 200 }, -- tourney_patas
    },

    {
        { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,   weight =  60 }, -- chunk_of_darksteel_ore
        { itemId = xi.item.GOLD_INGOT,               weight =  60 }, -- gold_ingot
        { itemId = xi.item.GOLD_BEASTCOIN,           weight =  60 }, -- gold_beastcoin
        { itemId = xi.item.MYTHRIL_BEASTCOIN,        weight =  60 }, -- mythril_beastcoin
        { itemId = xi.item.MYTHRIL_INGOT,            weight =  60 }, -- mythril_ingot
        { itemId = xi.item.PLATINUM_INGOT,           weight =  60 }, -- platinum_ingot
        { itemId = xi.item.RAM_HORN,                 weight =  60 }, -- ram_horn
        { itemId = xi.item.SCROLL_OF_REFRESH,        weight = 125 }, -- scroll_of_refresh
        { itemId = xi.item.RERAISER,                 weight = 145 }, -- reraiser
        { itemId = xi.item.SCROLL_OF_UTSUSEMI_NI,    weight = 125 }, -- scroll_of_utsusemi_ni
        { itemId = xi.item.SCROLL_OF_ICE_SPIKES,     weight = 125 }, -- scroll_of_ice_spikes
        { itemId = xi.item.HANDFUL_OF_WYVERN_SCALES, weight =  60 }, -- handful_of_wyvern_scales
    },

    {
        { itemId = xi.item.CORAL_FRAGMENT,       weight =  78 }, -- coral_fragment
        { itemId = xi.item.DARKSTEEL_INGOT,      weight =  78 }, -- darksteel_ingot
        { itemId = xi.item.DEMON_HORN,           weight =  78 }, -- demon_horn
        { itemId = xi.item.FIRE_SPIRIT_PACT,     weight = 125 }, -- fire_spirit_pact
        { itemId = xi.item.CHUNK_OF_GOLD_ORE,    weight =  78 }, -- chunk_of_gold_ore
        { itemId = xi.item.MYTHRIL_INGOT,        weight =  78 }, -- mythril_ingot
        { itemId = xi.item.PETRIFIED_LOG,        weight =  78 }, -- petrified_log
        { itemId = xi.item.RAM_HORN,             weight =  78 }, -- ram_horn
        { itemId = xi.item.SCROLL_OF_ABSORB_STR, weight = 125 }, -- scroll_of_absorb-str
        { itemId = xi.item.SCROLL_OF_ERASE,      weight = 125 }, -- scroll_of_erase
        { itemId = xi.item.SCROLL_OF_PHALANX,    weight = 125 }, -- scroll_of_phalanx
    },

    {
        { itemId = xi.item.NONE,                  weight = 850 }, -- nothing
        { itemId = xi.item.RAM_SKIN,              weight =  50 }, -- ram_skin
        { itemId = xi.item.MAHOGANY_LOG,          weight =  50 }, -- mahogany_log
        { itemId = xi.item.CHUNK_OF_PLATINUM_ORE, weight =  50 }, -- platinum_ore
    },
}

return content:register()
