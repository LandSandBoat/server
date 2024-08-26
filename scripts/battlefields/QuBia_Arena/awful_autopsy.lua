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
        { item = xi.item.UNDEAD_SKIN, weight = 1000 }, -- undead_skin
    },

    {
        { item = xi.item.NONE,         weight = 500 }, -- nothing
        { item = xi.item.RIVAL_RIBBON, weight = 250 }, -- rival_ribbon
        { item = xi.item.SUPER_RIBBON, weight = 250 }, -- super_ribbon
    },

    {
        { item = xi.item.NONE,          weight = 250 }, -- nothing
        { item = xi.item.IVORY_MITTS,   weight = 250 }, -- ivory_mitts
        { item = xi.item.RUSH_GLOVES,   weight = 250 }, -- rush_gloves
        { item = xi.item.SLY_GAUNTLETS, weight = 250 }, -- sly_gauntlets
    },

    {
        { item = xi.item.NONE,            weight = 200 }, -- nothing
        { item = xi.item.HEAVY_MANTLE,    weight = 200 }, -- heavy_mantle
        { item = xi.item.ESOTERIC_MANTLE, weight = 200 }, -- esoteric_mantle
        { item = xi.item.SNIPERS_MANTLE,  weight = 200 }, -- snipers_mantle
        { item = xi.item.TEMPLARS_MANTLE, weight = 200 }, -- templars_mantle
    },

    {
        { item = xi.item.NONE,             weight = 200 }, -- nothing
        { item = xi.item.HATEFUL_COLLAR,   weight = 200 }, -- hateful_collar
        { item = xi.item.STORM_GORGET,     weight = 200 }, -- storm_gorget
        { item = xi.item.INTELLECT_TORQUE, weight = 200 }, -- intellect_torque
        { item = xi.item.BENIGN_NECKLACE,  weight = 200 }, -- benign_necklace
    },

    {
        { item = xi.item.NONE,            weight = 200 }, -- nothing
        { item = xi.item.DARKSTEEL_INGOT, weight = 200 }, -- darksteel_ingot
        { item = xi.item.EBONY_LOG,       weight = 200 }, -- ebony_log
        { item = xi.item.PETRIFIED_LOG,   weight = 200 }, -- petrified_log
        { item = xi.item.GOLD_INGOT,      weight = 200 }, -- gold_ingot
    },

    {
        { item = xi.item.NONE,            weight = 875 }, -- nothing
        { item = xi.item.SCROLL_OF_QUAKE, weight = 125 }, -- scroll_of_quake
    },
}

return content:register()
