-----------------------------------
-- An Awful Autopsy
-- Qu'Bia Arena BCNM50, Comet Orb
-- !additem 1177
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.QUBIA_ARENA,
    battlefieldId    = xi.battlefield.id.AWFUL_AUTOPSY,
    maxPlayers       = 3,
    levelCap         = 50,
    timeLimit        = utils.minutes(15),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.COMET_ORB, wearMessage = qubiaID.text.A_CRACK_HAS_FORMED, wornMessage = qubiaID.text.ORB_IS_CRACKED },
    armouryCrates    =
    {
        qubiaID.mob.CHAHNAMEEDS_STOMACH + 4,
        qubiaID.mob.CHAHNAMEEDS_STOMACH + 9,
        qubiaID.mob.CHAHNAMEEDS_STOMACH + 14,
    },
})

local handleDeath = function(battlefield, mob)
    local mobIdOffset = qubiaID.mob.CHAHNAMEEDS_STOMACH + (battlefield:getArea() - 1) * 5

    for mobId = mobIdOffset, mobIdOffset + 2 do
        local mobObj = GetMobByID(mobId)

        if
            mobObj and
            mobObj:isSpawned() and
            not mobObj:isDead()
        then
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
            { qubiaID.mob.CHAHNAMEEDS_STOMACH     },
            { qubiaID.mob.CHAHNAMEEDS_STOMACH + 4 },
            { qubiaID.mob.CHAHNAMEEDS_STOMACH + 8 },
        },

        death = handleDeath,
    },

    {
        mobIds =
        {
            {
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 1,
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 2,
            },

            {
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 5,
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 6,
            },

            {
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 9,
                qubiaID.mob.CHAHNAMEEDS_STOMACH + 10,
            },
        },

        death   = handleDeath,
        spawned = false,
    },
}

content.loot =
{
    {
        { itemId = xi.item.UNDEAD_SKIN, weight = 1000 }, -- undead_skin
    },

    {
        { itemId = xi.item.NONE,         weight = 500 }, -- nothing
        { itemId = xi.item.RIVAL_RIBBON, weight = 250 }, -- rival_ribbon
        { itemId = xi.item.SUPER_RIBBON, weight = 250 }, -- super_ribbon
    },

    {
        { itemId = xi.item.NONE,          weight = 250 }, -- nothing
        { itemId = xi.item.IVORY_MITTS,   weight = 250 }, -- ivory_mitts
        { itemId = xi.item.RUSH_GLOVES,   weight = 250 }, -- rush_gloves
        { itemId = xi.item.SLY_GAUNTLETS, weight = 250 }, -- sly_gauntlets
    },

    {
        { itemId = xi.item.NONE,            weight = 200 }, -- nothing
        { itemId = xi.item.HEAVY_MANTLE,    weight = 200 }, -- heavy_mantle
        { itemId = xi.item.ESOTERIC_MANTLE, weight = 200 }, -- esoteric_mantle
        { itemId = xi.item.SNIPERS_MANTLE,  weight = 200 }, -- snipers_mantle
        { itemId = xi.item.TEMPLARS_MANTLE, weight = 200 }, -- templars_mantle
    },

    {
        { itemId = xi.item.NONE,             weight = 200 }, -- nothing
        { itemId = xi.item.HATEFUL_COLLAR,   weight = 200 }, -- hateful_collar
        { itemId = xi.item.STORM_GORGET,     weight = 200 }, -- storm_gorget
        { itemId = xi.item.INTELLECT_TORQUE, weight = 200 }, -- intellect_torque
        { itemId = xi.item.BENIGN_NECKLACE,  weight = 200 }, -- benign_necklace
    },

    {
        { itemId = xi.item.NONE,            weight = 200 }, -- nothing
        { itemId = xi.item.DARKSTEEL_INGOT, weight = 200 }, -- darksteel_ingot
        { itemId = xi.item.EBONY_LOG,       weight = 200 }, -- ebony_log
        { itemId = xi.item.PETRIFIED_LOG,   weight = 200 }, -- petrified_log
        { itemId = xi.item.GOLD_INGOT,      weight = 200 }, -- gold_ingot
    },

    {
        { itemId = xi.item.NONE,            weight = 875 }, -- nothing
        { itemId = xi.item.SCROLL_OF_QUAKE, weight = 125 }, -- scroll_of_quake
    },
}

return content:register()
